class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[show edit update destroy]
  before_action :check_user_ownership, only: %i[show edit update destroy]
  before_action :set_type, only: %i[index new create]

  def index
    @links = current_user.links.where(user_id: current_user.id, type: @type)
    if @links.size.zero?
      redirect_to root_path, notice: "No tienes links creados."
    end
    @links = @links.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @new_go_back = params[:new_go_back]
    @link = Link.new
  end

  def create
    @link = current_user.links.build(link_params.merge(type: params[:type].constantize))
    if @link.save
      redirect_to link_path(@link), notice: "#{@link.type.humanize} link was successfully created."
    else
      @new_go_back = params[:new_go_back]
      render :new, status: :unprocessable_entity, locals: { type: @type, new_go_back: @new_go_back }, notice: "Error"
    end
  end

  def edit
    @edit_go_back = params[:edit_go_back]
    @link = Link.find(params[:id])
    @type = @link.type
  end

  def update
    if @link.update(link_params)
      redirect_to link_path(@link), notice: "#{@link.type.humanize} link was successfully updated."
    else
      @type = @link.type
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy!
    redirect_to links_path(type: @link.type), notice: "Link was successfully destroyed."
  end

  private

  def check_user_ownership
    render file: "#{Rails.root}/public/403.html", status: :forbidden, layout: false unless @link.user == current_user
  end

  def set_type
    type = params[:type]
    if type.nil? || type.empty? || !Link::TYPES.include?(type)
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    else
      @type = type
    end
  end

  def set_link
    link = current_user.links.find_by(id: params[:id])
    if link.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if link.nil?
    else
      @link = link
      @final_url = combine_attributes(@link)
    end
  end

  def link_params
    params.require(:link).permit(:name, :destination_url, :expiration_date, :password)
  end

  def combine_attributes(link)
    public_link_url(slug: link.slug)
  end
end
