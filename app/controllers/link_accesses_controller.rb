class LinkAccessesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_link_accesses, only: %i[index]

    def index
      @access_go_back = params[:access_go_back] || polymorphic_path(@link)
      @q = @accesses.ransack(params[:q])
      @link_accesses = @q.result().page(params[:page]).per(10)
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
          @accesses = @link.link_accesses.order("accessed_at DESC").merge(@q.result)
        else
          render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
        end
      end

    def set_link_access_per_day
      result = LinkAccess.where(link_id: params[:link_id]).order("accessed_at DESC").group("strftime('%d-%m-%Y', accessed_at)").count
      @access_per_day = Kaminari.paginate_array(result.to_a).page(params[:access_page]).per(5)
    end
end
