module HomeHelper
  def render_links(links)
    if links.present?
      links.map do |link|
        render_link(link)
      end.join.html_safe
    else
      content_tag(:p, 'No hay enlaces disponibles.')
    end
  end

  def render_link(link)
    content_tag(:div, class: 'link') do
      content_tag(:p) do
        link_name = link.name.present? ? link.name : 'Link sin nombre'
        link_to(link_name, link_path(link)) +
        content_tag(:span, " (#{link.access_count})", class: 'access-count')
      end
    end
  end
end
