class PrivateLinksController < ApplicationController
  before_action :set_private_link, only: %i[ show edit update destroy ]

  # GET /private_links or /private_links.json
  def index
    @private_links = PrivateLink.all.where(user_id: current_user.id)
  end

  # GET /private_links/1 or /private_links/1.json
  def show
  end

  # GET /private_links/new
  def new
    @private_link = PrivateLink.new
  end

  # GET /private_links/1/edit
  def edit
  end

  # POST /private_links or /private_links.json
  def create
    @private_link = PrivateLink.new(private_link_params)

    respond_to do |format|
      if @private_link.save
        format.html { redirect_to private_link_url(@private_link), notice: "Private link was successfully created." }
        format.json { render :show, status: :created, location: @private_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @private_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /private_links/1 or /private_links/1.json
  def update
    respond_to do |format|
      if @private_link.update(private_link_params)
        format.html { redirect_to private_link_url(@private_link), notice: "Private link was successfully updated." }
        format.json { render :show, status: :ok, location: @private_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @private_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_links/1 or /private_links/1.json
  def destroy
    @private_link.destroy!

    respond_to do |format|
      format.html { redirect_to private_links_url, notice: "Private link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_link
      @private_link = PrivateLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def private_link_params
      params.require(:private_link).permit(:slug, :name, :destination_url, :user_id, :password)
    end
end
