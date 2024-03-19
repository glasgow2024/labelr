class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include JSONAPI::Errors

  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action do
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end

  def json_request?
    request.format.json?
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def prevent_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def pundit_user
    current_user
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized(e)
    error = { status: '403', title: e.message }
    render json: [error], adapter: :json, status: :unauthorized, content_type: 'application/json'
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def record_not_found(e)
    error = { status: '404', title: e.message }
    render json: [error], adapter: :json, status: :not_found, content_type: 'application/json'
  end

  rescue_from ActiveRecord::ActiveRecordError, with: :processing_error
  rescue_from RuntimeError, with: :processing_error
  rescue_from ActiveRecord::RecordInvalid, with: :processing_error
  def processing_error(e)
    Rails.logger.error e.message if Rails.env.development?
    Rails.logger.error e.backtrace.join("\n\t") if Rails.env.development?

    error = { status: '422', title: e.message, detail: e.full_message, source: e.cause }
    render json: [error], adapter: :json, status: :unprocessable_entity, content_type: 'application/json'
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me email_addresses_attributes]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

    devise_parameter_sanitizer.permit(:sign_in) do |user|
      user.permit(
        :username,
        :password,
        :remember_me,
        email_addresses_attributes: [:email]
      )
    end
  end

  def render_jsonapi_internal_server_error(exception)
    Rails.logger.error exception.message #if Rails.env.development?
    Rails.logger.error exception.backtrace.join("\n\t") #if Rails.env.development?
    # NOTE: if we have a central log put it in here
    super(exception)
  end
end
