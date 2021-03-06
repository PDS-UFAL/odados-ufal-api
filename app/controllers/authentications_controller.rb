class AuthenticationsController < ApplicationController
  ALLOWED_ACTIONS_WITHOUT_USER = [:login]

  skip_before_action :authenticate_user, only: ALLOWED_ACTIONS_WITHOUT_USER
  skip_load_and_authorize_resource only: ALLOWED_ACTIONS_WITHOUT_USER

  # POST /login
  def login
    user = User.find_by(email: user_params[:email])

    if not user&.active?
      return render json: { error: 'Usuário bloqueado no sistema, para reativá-lo entre em contato com o administrador' }, status: :unauthorized
    end

    if user&.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode( { id: user.id, email: user.email } )
      
      render json: { user: UserSerializer.new(user), token: auth_token }
    else
      render json: { error: 'Email ou senha inválidos' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end