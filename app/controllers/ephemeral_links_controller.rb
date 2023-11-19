class EphemeralLinksController < ApplicationController
  before_action :set_ephemeral_link, only: %i[ show edit update destroy ]

  # GET /ephemeral_links or /ephemeral_links.json
  def index
    @ephemeral_links = EphemeralLink.all
  end

  # GET /ephemeral_links/1 or /ephemeral_links/1.json
  def show
  end

  # GET /ephemeral_links/new
  def new
    @ephemeral_link = EphemeralLink.new
  end

  # GET /ephemeral_links/1/edit
  def edit
  end

  # POST /ephemeral_links or /ephemeral_links.json
  def create
    @ephemeral_link = EphemeralLink.new(ephemeral_link_params)

    respond_to do |format|
      if @ephemeral_link.save
        format.html { redirect_to ephemeral_link_url(@ephemeral_link), notice: "Ephemeral link was successfully created." }
        format.json { render :show, status: :created, location: @ephemeral_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ephemeral_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ephemeral_links/1 or /ephemeral_links/1.json
  def update
    respond_to do |format|
      if @ephemeral_link.update(ephemeral_link_params)
        format.html { redirect_to ephemeral_link_url(@ephemeral_link), notice: "Ephemeral link was successfully updated." }
        format.json { render :show, status: :ok, location: @ephemeral_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ephemeral_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ephemeral_links/1 or /ephemeral_links/1.json
  def destroy
    @ephemeral_link.destroy!

    respond_to do |format|
      format.html { redirect_to ephemeral_links_url, notice: "Ephemeral link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ephemeral_link
      @ephemeral_link = EphemeralLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ephemeral_link_params
      params.require(:ephemeral_link).permit(:slug, :name, :destination_url, :user_id, :used)
    end
end
