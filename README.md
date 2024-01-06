<h1 align="center">
  Chq.to
</h1>
<br/>

# Pasos previos

Antes de ejecutar la aplicación es necesario realizar los siguientes pasos:

1. Instalar dependencias (Opcional):

  Si bien se provee el Gemfile.lock, en caso de decidir reinstalar las dependencias puede hacerse con

```bash
#bash
rm Gemfile.lock
bundle
```

2. Crear base de datos y correr las migraciones:
```bash
#bash
rails db:migrate
```

3. Cargar datos de prueba
   
```bash
#bash

#Usuarios:
#email: user1@example.com
#password: password1

#email: user2@example.com (sin accesos a los links)
#password: password2

#email: user3@example.com (sin enlaces)
#password: password3

rake db:seed
```

# Ejecución:
```bash
#bash
rails s
```

# Diseño

## Aclaración: 

Soy consciente de que el principio de Convención sobre Configuración (COC) fue afectado, debido a algunas decisiones de diseño tomadas previo a iniciar el desarrollo, diseño que fue mutando en parte por algunos errores encontrados cuando la aplicación se encontraba avanzada y por otro lado debido a mi inexperiencia con el framework Rails. Una vez determinado el curso del modelado de la aplicación, se priorizó en gran parte el principio DRY, siempre que se pudo y que no se consideró que afectara a la estructura de la aplicación. 

## Base de datos

### Tablas

- `users` (id, email, encrypted_password, user_name, name, created_at, updated_at)
  <br/>
  Se delegó la funcionalidad de autenticación a la gema `devise` y se removieron los atributos no deseados para la implementación del sistema.
  <br/>
- `links` (id, slug, destination_url, name, user_id, type, expiration_date, password, used, created_at, updated_at)
  <br/>
  Se creó una sola tabla bajo el esquema STI (Single Table Inheritance) con el fin de poder representar los links como una jerarquía debido a la compartición de atriburos, dejando como opcionales a nivel base de datos aquellos específicos de cada clase.
  <br/>
- `link_accesses` (id, link_id, accessed_at, ip_address, created_at, updated_at)
  <br/>
  En ella se registran los accesos a los diferentes tipos de links en caso de que corresponda.


## Aplicación

### Modelos

- User
- LinkAccess

- Link

Existe una clase `Link` que aglutina todos los atributos en común de los enlaces (id, slug, destination_url, name, user_id, type, created_at, updated_at) y luego especificaciones para los distintos tipos:

- RegularLink
- TemporalLink (...expiration_date)
- PrivateLink (...password)
- EphemeralLink (...used)

`Nota`: Si bien la clase RegularLink no posee atributos ni comportamiento adicional, se creó con el objetivo de respetar la existencia de todos los tipos de links solicitados, sin tener que convertirla en la superclase y poder manejar a todos como especificaciones a través del atributo type.


### Controladores

- `ApplicationController`
- `HomeController` < `ApplicationController`: utilizado para listar los distintos tipos de links de un usuario.
- `LinkRedirectionController` < `ApplicationController`: Para el manejo de las redirecciones de los links una vez que son accedidos.
- `LinkAccessesController` < `ApplicationController`: Para el registro de los accesos a los links.
- `ErrorsController` < `ApplicationController`: Para el retorno de templates de error como not found.

- `LinksController` < `ApplicationController`

- Controladores definidos por `devise` para el manejo de usuarios, sesiones y autenticación.


### Vistas

Se realizaron ciertos partials para algunos elementos compartidos, pero manteniendo también vistas y componentes específicos a fin de facilitar el desarrollo:

- `links`: Formularios y elementos compartidos entre todos los links.
- `link_accesses`: Vistas para el muestreo de accesos totales y diarios de los links.
- `users`: Vistas creadas por devise para el manejo de usuarios.
- `home`: Punto de entrada de la aplicación, donde se listan los 5 links mas visitados de cada tipo, los cuales son renderizados haciendo uso de un helper (HomeHelper), evitando así la sobre carga de la vista.

### Generación del slug

Se definió una clase sencilla "SlugGenerator" (lib/slug_generator.rb) diseñada para generar slugs únicos de un tamaño específico a partir de un conjunto de caracteres (letras mayúsculas, minúsculas y números), evitando colisiones con los slugs existentes en la base de datos. A medida que se generan más slugs y se acerca a un umbral predefinido (75% de las combinaciones posibles), la longitud del slug se incrementa para mantener una baja probabilidad de repeticiones. 
