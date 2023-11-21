class TemporalLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_temporal_link, only: %i[ show edit update destroy ]
  before_action :check_user_ownership, only: %i[show edit update destroy]

  # GET /temporal_links or /temporal_links.json
  def index
    @temporal_links = TemporalLink.all.where(user_id: current_user.id)
  end

  # GET /temporal_links/1 or /temporal_links/1.json
  def show
  end

  # GET /temporal_links/new
  def new
    @temporal_link = TemporalLink.new
  end

  # GET /temporal_links/1/edit
  def edit
  end

  # POST /temporal_links or /temporal_links.json
  def create
    @temporal_link = current_user.temporal_links.build(temporal_link_params)
    @temporal_link.slug = SlugGenerator.generate

    if @temporal_link.save
      redirect_to @temporal_link, notice: 'Temporal link was successfully created.'
    else
      respond_to do |format|
      # show errors
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @temporal_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temporal_links/1 or /temporal_links/1.json
  def update
    respond_to do |format|
      if @temporal_link.update(temporal_link_params)
        format.html { redirect_to temporal_link_url(@temporal_link), notice: "Temporal link was successfully updated." }
        format.json { render :show, status: :ok, location: @temporal_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @temporal_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temporal_links/1 or /temporal_links/1.json
  def destroy
    @temporal_link.destroy!

    respond_to do |format|
      format.html { redirect_to temporal_links_url, notice: "Temporal link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def check_user_ownership
    unless @temporal_link.user == current_user
      redirect_to temporal_links_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_temporal_link
      @temporal_link = TemporalLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temporal_link_params
      params.require(:temporal_link).permit(:slug, :name, :destination_url, :user_id, :expiration_date)
    end
end
