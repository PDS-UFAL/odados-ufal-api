class SectorsController < ApplicationController
  before_action :set_sector, only: [:show, :update, :destroy]

  def index
    @sectors = Sector.all

    render json: @sectors
  end

  def show
    render json: @sector
  end

  def create
    @sector = Sector.new(sector_params)

    if @sector.save
      render json: @sector, status: :created
    else
      render json: @sector.errors, status: :unprocessable_entity
    end
  end

  def update
    if @sector.update(sector_params)
      render json: @sector
    else
      render json: @sector.errors, status: :unprocessable_entity
    end
  end

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
