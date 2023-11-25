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
      create_link_access(@link)
      redirect_to link.destination_url, allow_other_host: true
    else
      render '_access_private_form', locals: { link: link }
    end
  end
  

  private

  def access_regular(link)
    create_link_access(@link)
    redirect_to link.destination_url, allow_other_host: true
  end

  def access_temporal(link)
    if link.expiration_date < Time.now
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    else
      create_link_access(@link)
      redirect_to link.destination_url, allow_other_host: true
    end
  end

  def access_private_form(link)
    render '_access_private_form', locals: { link: link }
  end

  def access_ephemeral(link)
    if link.used
      render file: "#{Rails.root}/public/403.html", status: :not_found, layout: false
    else
      link.update(used: true)
      create_link_access(@link)
      redirect_to link.destination_url, allow_other_host: true
    end
  end

  def create_link_access(link)
    link.link_accesses.create!(
      accessed_at: Time.now,
      ip_address: request.remote_ip
    )
  end

end
