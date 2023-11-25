class LinkAccessesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_link_accesses, only: %i[index]

    def index
        @q = @accesses.ransack(params[:q])
        @link_accesses = @q.result()
      end     
    
    def show
        @link_access = LinkAccess.find(params[:id])
    end

    def create
        @link_access = LinkAccess.new(link_access_params)
    
        if @link_access.save
          render json: { status: 'success', message: 'Link access created successfully' }
        else
          render json: { status: 'error', message: 'Failed to create link access', errors: @link_access.errors.full_messages }
        end
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
          # No se proporcionó link_id, obtenemos resultados según los parámetros de Ransack
          @accesses = @q.result(distinct: true)
        end
      end
      
end
