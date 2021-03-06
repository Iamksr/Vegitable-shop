class ApplicationController < ActionController::Base  
  helper_method :current_cart
  before_action :authenticate_user!
   before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_admin, expect:[:after_sign_in_path_for]
  include ApplicationHelper
  layout :set_layout
  # before_action :check_subscription
  def after_sign_in_path_for(resource)
    resource.is_admin? ? admin_root_path : root_path
  end

  def user_admin
    if request.fullpath.split("/")[1] == "admin"
      if current_user.present?
        if current_user.role != 'admin'
          redirect_to root_path
        else
          request.url
        end
        else
          flash[:notice] = "you need to sign in or sign up"
          redirect_to "/users/sign_in"
      end
    end
  end

  def authentication_admin!
    unless current_user.is_admin?
      redirect_to(request.referrer || root_path)
    end
  end
 
  def current_cart
    if current_user.present?
      return Cart.find_or_create_by(user_id: current_user.id, is_done: false)
    end
  end

  protected   
    def configure_permitted_parameters  
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit({ roles: [] }, :email, :password, :password_confirmation,:name, :gender,:phone, :image, :is_active, :is_admin, :city, :state, :zip_code, :latitude, :longitude, :country, :product_id)
    end
      devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit({ roles: [] }, :email, :password, :password_confirmation,:name, :gender,:phone, :image, :address,:current_password, :is_active, :is_admin, :city, :state, :zip_code, :latitude, :longitude, :country, :product_id)
  end
  
end
end