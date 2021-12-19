module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from CanCan::AccessDenied do |e|
      render json: { error: e.message }, status: :forbidden
    end
    
    rescue_from ActiveRecord::RecordInvalid, AASM::InvalidTransition do |e|
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end