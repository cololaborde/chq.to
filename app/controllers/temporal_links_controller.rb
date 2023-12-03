class TemporalLinksController < LinksController
    def link_params
        params.require(:temporal_link).permit(:name, :destination_url, :expiration_date)
    end
end
