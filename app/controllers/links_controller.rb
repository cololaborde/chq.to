class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[show edit update destroy]
  before_action :check_user_ownership, only: %i[show edit update destroy]

  def index
    type = params[:type]
    @links = current_user.links.where(user_id: current_user.id, type: type)
    redirect_to root_path, notice: "No tienes #{controller_name.humanize} creados." if @links.empty?
    @links = @links.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @new_go_back = params[:new_go_back]
    set_type
    @link = Link.new
  end

  def edit
    @edit_go_back = params[:edit_go_back]
  end

  def create
    @link = current_user.links.build(link_params)
    @link.type = params[:type]

    if @link.save
      redirect_to @link, notice: "#{controller_name.humanize} link was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      redirect_to @link, notice: "#{controller_name.humanize} link was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy!
    redirect_to send("#links_url"), notice: "#{controller_name.humanize} link was successfully destroyed."
  end

  private

  def check_user_ownership
    render file: "#{Rails.root}/public/403.html", status: :forbidden, layout: false unless @link.user == current_user
  end

  def set_type
    @type = params[:type]
  end

  def set_link
    link = current_user.links.find_by(id: params[:id])
    puts "linkardo: ", link.inspect
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if link.nil?

    @link = link
    @final_url = combine_attributes(@link)
  end

  def link_params
    params.require(:link).permit(:name, :destination_url, :expiration_date, :password)
  end

  def combine_attributes(link)
    public_link_url(slug: link.slug)
  end
end
