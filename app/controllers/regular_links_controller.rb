class RegularLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_regular_link, only: %i[ show edit update destroy ]
  before_action :check_user_ownership, only: %i[show edit update destroy]


  # GET /regular_links or /regular_links.json
  def index
    @regular_links = RegularLink.all.where(user_id: current_user.id)
  end

  # GET /regular_links/1 or /regular_links/1.json
  def show
  end

  # GET /regular_links/new
  def new
    @regular_link = RegularLink.new
  end

  # GET /regular_links/1/edit
  def edit
  end

  # POST /regular_links or /regular_links.json
  def create
    @regular_link = current_user.regular_links.build(regular_link_params)
    @regular_link.slug = SlugGenerator.generate

    if @regular_link.save
      redirect_to @regular_link, notice: 'Regular link was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /regular_links/1 or /regular_links/1.json
  def update
    respond_to do |format|
      if @regular_link.update(regular_link_params)
        format.html { redirect_to regular_link_url(@regular_link), notice: "Regular link was successfully updated." }
        format.json { render :show, status: :ok, location: @regular_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @regular_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regular_links/1 or /regular_links/1.json
  def destroy
    @regular_link.destroy!

    respond_to do |format|
      format.html { redirect_to regular_links_url, notice: "Regular link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def check_user_ownership
      unless @regular_link.user == current_user
        redirect_to regular_links_path, alert: 'No tienes permisos para realizar esta acción.'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_regular_link
      @regular_link = RegularLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def regular_link_params
      params.require(:regular_link).permit(:name, :destination_url)
    end
end
