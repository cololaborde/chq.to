class LinkAccessesController < ApplicationController
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
        params.require(:link_access).permit(:link_id, :accessed_at, :user_ip)
      end
    end
end
