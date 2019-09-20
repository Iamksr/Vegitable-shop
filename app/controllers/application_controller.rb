class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :authenticate_user!

 	protected



	def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up) do |user_params|

	user_params.permit({ roles: [] }, :email, :password, :password_confirmation,:name,:phone,:gender,:address)

	end



	devise_parameter_sanitizer.permit(:account_update) do |user_params|

	user_params.permit({ roles: [] }, :email, :password, :password_confirmation,:name,:phone,:gender,:address)

	end
	end

	 def current_cart
    if current_user.present?
      return Cart.find_or_create_by(user_id: current_user.id, is_done: false)
    end
  end
  helper_method :current_cart
  
end