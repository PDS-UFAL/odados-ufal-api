class UsersController < ApplicationController
  ALLOWED_ACTIONS_WITHOUT_USER = [:create, :forgot_password, :reset_password]

  skip_before_action :authenticate_user, only: ALLOWED_ACTIONS_WITHOUT_USER
  skip_load_and_authorize_resource only: ALLOWED_ACTIONS_WITHOUT_USER

  before_action :set_user, only: [:show, :update, :destroy, :turn_inactive]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # PUT /users/1/turn_inactive 
  def turn_inactive  
    if @user.update({ active: false })
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/1/turn_active
  def turn_active 
    if @user.update({ active: true })
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @params = user_params
    @user = User.where(email: @params[:email], name: @params[:sector_id], sector_id: @params[:sector_id])[0]

    if @user.nil?
      @user = User.new(@params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      if @user.update({ active: true })
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /users/1
  def update    
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # GET /users/me
  def me
    render json: @current_user
  end

  # POST /users/forgot_password
  def forgot_password
    @user = User.find_by!(email: params[:email])

    if @user.generate_password_token!
      render nothing: true, status: :no_content
    else
      render json: { errors: 'failed to send password reset email' }, status: :unprocessable_entity
    end
  end

  # POST /users/reset_password
  def reset_password
    @user = User.find_by!(reset_password_token: params[:token])

    if @user.reset_password!(reset_password_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    perm_params = params.require(:user).permit(:email, :name, :password, :password_confirmation, :sector_id)
    if perm_params[:password].nil? 
      perm_params[:password] = SecureRandom.hex(8)
      perm_params[:password_confirmation] = perm_params[:password]
    end
    perm_params
  end

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
