class NotificationsController < ApplicationController
  ALLOWED_ACTIONS_WITHOUT_USER = [:index]

  skip_before_action :authenticate_user, only: ALLOWED_ACTIONS_WITHOUT_USER
  skip_load_and_authorize_resource only: ALLOWED_ACTIONS_WITHOUT_USER

  before_action :set_notification, only: [:show, :update, :destroy]

  def index
    @notifications = Notification.all

    render json: @notifications
  end

  def show
    render json: @notification
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      render json: @notification, status: :created
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @notification.destroy
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:content, :category, :user_id)
  end

  # def update_notification_params
  #   params.require(:user).permit(:content, :category, :user_id)
  # end
end
