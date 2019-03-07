class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_error(model)
    render json: { errors: model.errors.full_messages.join(',') }, status: 422
  end

  def handle_flash key, value
    flash[key] = value
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end
end