document.addEventListener('DOMContentLoaded', () => {
  const handleClipboardClick = (event) => {
    const button = event.target.closest('.clipboard-btn');
    if (button) {
      const textToCopy = button.getAttribute('data-clipboard-text');

      navigator.clipboard.writeText(textToCopy)
        .then(() => {
          const notice = document.createElement('div');
          notice.classList.add('notice');
          notice.textContent = '¡Enlace copiado al portapapeles!';
          document.body.appendChild(notice);
        })
        .catch(err => console.error('Error al copiar al portapapeles', err));
    }
  };

  document.removeEventListener('click', handleClipboardClick);
  document.addEventListener('click', handleClipboardClick);
});