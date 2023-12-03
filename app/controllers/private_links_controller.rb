class PrivateLinksController < LinksController
    def link_params
        params.require(:private_link).permit(:name, :destination_url, :password)
    end
end
