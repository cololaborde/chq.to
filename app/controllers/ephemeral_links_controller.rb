class EphemeralLinksController < BaseLinksController

  def create
    @ephemeral_link = current_user.ephemeral_links.build(ephemeral_link_params)
    @ephemeral_link.used = false
    @ephemeral_link.slug = SlugGenerator.generate

    if @ephemeral_link.save
      redirect_to @ephemeral_link, notice: 'Ephemeral link was successfully created.'
    else
      respond_to do |format|
        # show errors
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ephemeral_link.errors, status: :unprocessable_entity }
        end
    end
  end
end