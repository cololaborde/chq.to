class LinkRedirectionController < ApplicationController
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
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  def access_private
    link = Link.find_by(id: params[:id])
    
    if link.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    elsif params[:password].present? && link.password == params[:password]
      create_access_and_redirect(link)
    else
      render 'links/_access_private_form', locals: { link: link }
    end
  end
  

  private

  def access_regular(link)
    create_access_and_redirect(link)
  end

  def access_temporal(link)
    if link.expiration_date < Time.now
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    else
      create_access_and_redirect(link)
    end
  end

  def access_private_form(link)
    render 'links/_access_private_form', locals: { link: link }
  end

  def access_ephemeral(link)
    if link.used
      render file: "#{Rails.root}/public/403.html", status: :not_found, layout: false
    else
      link.update(used: true)
      create_access_and_redirect(link)
    end
  end

  def create_access_and_redirect(link)
    link.link_accesses.create!(
      accessed_at: Time.now,
      ip_address: request.remote_ip
    )
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    response.headers['Access-Control-Request-Method'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    redirect_to link.destination_url, allow_other_host: true
  end

end
