class BaseLinksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_link, only: %i[show edit update destroy]
    before_action :check_user_ownership, only: %i[show edit update destroy]
  
    def index
      instance_variable_set("@#{controller_name}", current_user.send(controller_name).all.where(user_id: current_user.id))
    end
  
    def show
      def show
      end
    end
  
    def new
      instance_variable_set("@#{controller_name.singularize}", controller_name.classify.constantize.new)
    end
  
    def edit
    end
  
    def create
      instance_variable_set("@#{controller_name.singularize}", current_user.send(controller_name).build(link_params))
      instance_variable_get("@#{controller_name.singularize}").slug = SlugGenerator.generate
  
      if instance_variable_get("@#{controller_name.singularize}").save
        redirect_to instance_variable_get("@#{controller_name.singularize}"), notice: "#{controller_name.humanize} link was successfully created."
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: instance_variable_get("@#{controller_name.singularize}").errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      respond_to do |format|
        if instance_variable_get("@#{controller_name.singularize}").update(link_params)
          format.html { redirect_to send("#{controller_name.singularize}_url", instance_variable_get("@#{controller_name.singularize}")), notice: "#{controller_name.humanize} link was successfully updated." }
          format.json { render :show, status: :ok, location: instance_variable_get("@#{controller_name.singularize}") }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: instance_variable_get("@#{controller_name.singularize}").errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      instance_variable_get("@#{controller_name.singularize}").destroy!
  
      respond_to do |format|
        format.html { redirect_to send("#{controller_name}_url"), notice: "#{controller_name.humanize} link was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
  
    def check_user_ownership
      unless instance_variable_get("@#{controller_name.singularize}").user == current_user
        render file: "#{Rails.root}/public/403.html", status: :not_found, layout: false
      end
    end
  
    def set_link
        link = current_user.send(controller_name).find_by(id: params[:id])
        
        if link.nil?
            render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
        else
            instance_variable_set("@#{controller_name.singularize}", link)
            @final_url = combine_attributes(instance_variable_get("@#{controller_name.singularize}"))
        end
    end
  
    def link_params
      params.require(controller_name.singularize.to_sym).permit(:slug, :name, :destination_url, :user_id, :password, :expiration_date)
    end

    def combine_attributes(link)
      "http://#{request.host_with_port}/l/#{link.slug}"
    end

  end
  