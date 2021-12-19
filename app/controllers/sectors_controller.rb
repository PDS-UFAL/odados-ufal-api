class SectorsController < ApplicationController
  ALLOWED_ACTIONS_WITHOUT_USER = []

  skip_before_action :authenticate_user, only: ALLOWED_ACTIONS_WITHOUT_USER
  skip_load_and_authorize_resource only: ALLOWED_ACTIONS_WITHOUT_USER
  
  before_action :set_sector, only: [:show, :update, :destroy]

  # GET /sectors
  def index
    @sectors = Sector.all

    render json: @sectors
  end

  # GET /sectors/1
  def show
    render json: @sector
  end

  # POST /sectors
  def create
    @sector = Sector.new(sector_params)

    if @sector.save
      render json: @sector, status: :created
    else
      render json: @sector.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sectors/1
  def update
    if @sector.update(sector_params)
      render json: @sector
    else
      render json: @sector.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sectors/1
  def destroy
    @sector.destroy
  end

  private

  def set_sector
    @sector = Sector.find(params[:id])
  end

  def sector_params
    params.require(:sector).permit(:name, :email, :responsible)
  end
end
