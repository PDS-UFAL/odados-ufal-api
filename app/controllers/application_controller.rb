class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authenticate_user
  load_and_authorize_resource

  attr_reader :current_user

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ') if header
    
    if !header || header.first != "Bearer"|| header.size != 2
     render json: { errors: 'Token JWT vazio!'}, status: :unauthorized
    else
      begin
        @decoded = JsonWebToken.decode(header.last)
        @current_user = User.where(email: @decoded[:email]).find(@decoded[:id])
      rescue 
        render json: { errors: 'Token JWT inválido!' }, status: :unauthorized
      end
    end
  end

  def pagination_info collection
    if params[:page].present?
      {
        total_pages: collection.total_pages,
        total_count: collection.total_count
      }
    end
  end

  def sort_directions
    ["asc", "desc"]
  end
end
