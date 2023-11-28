class PrivateLinksController < LinksController
    def link_params
        params.require(:private_link).permit(:slug, :name, :destination_url, :password)
    end
end
