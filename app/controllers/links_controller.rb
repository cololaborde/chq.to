# app/controllers/links_controller.rb
class LinksController < ApplicationController
  def access
    @link = Link.find_by(slug: params[:slug])
    case @link
    when RegularLink
      access_regular(@link)
    when TemporalLink
      access_temporal(@link)
    when PrivateLink
      access_private_form(@link)
    when EphemeralLink
      access_ephemeral(@link)
    else
      redirect_to root_path, alert: "Enlace no válido"
    end
  end

  def access_private
    link = Link.find_by(id: params[:id])
    
    if link.nil?
      redirect_to root_path, alert: "Enlace no válido"
    elsif params[:password].present? && link.password == params[:password]
      redirect_to link.destination_url, allow_other_host: true
    else
      redirect_to root_path, alert: "Contraseña incorrecta"
    end
  end
  

  private

  def access_regular(link)
    redirect_to link.destination_url, allow_other_host: true
  end

  def access_temporal(link)
    if link.expiration_date < Time.now
      redirect_to root_path, alert: "El enlace ha expirado"
    else
      redirect_to link.destination_url, allow_other_host: true
    end
  end

  def access_private_form(link)
    render '_access_private_form', locals: { link: link }
  end

  def access_ephemeral(link)
    if link.used
      redirect_to root_path, alert: "El enlace ya ha sido utilizado"
    else
      link.update(used: true)
      redirect_to link.destination_url, allow_other_host: true
    end
  end
end
