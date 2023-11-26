class LinkAccessesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_link_accesses, only: %i[index]

    def index
      @q = @accesses.ransack(params[:q])
      @link_accesses = @q.result()
      set_link_access_per_day
    end     
    
    private
    
    def link_access_params
        params.require(:link_access).permit(:link_id, :accessed_at, :ip_address)
    end

    def set_link_accesses
        @q = LinkAccess.ransack(params[:q])
      
        if params[:link_id].present?
          # Se proporcionó link_id, filtramos por ese enlace específico
          @link = current_user.links.find(params[:link_id])
          @accesses = @link.link_accesses.merge(@q.result)
        else
          render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
        end
      end

    def set_link_access_per_day
      @access_per_day = LinkAccess.where(link_id: params[:link_id]).group("strftime('%Y-%m-%d', accessed_at)").count
    end
end
