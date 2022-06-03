class SectorsController < ApplicationController
  before_action :set_sector, only: [:show, :update, :destroy]

  # GET /sectors
  def index
    @sectors = Sector.all
    render json: @sectors, each_serializer: SectorSerializer, users_flag: params[:show_users].present?
  end

  # GET /sectors/1
  def show
    render json: @sector, serializer: SectorSerializer, users_flag: params[:show_users].present?
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
    params.require(:sector).permit(:name, :abbreviation, :email, :responsible)
  end
end
