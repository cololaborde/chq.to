class LinkAccessesController < ApplicationController
    before_action :authenticate_user!

    def index
        @link_accesses = current_user.links.where(id: params[:link_id]).includes(:link_accesses).flat_map(&:link_accesses)
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
end
