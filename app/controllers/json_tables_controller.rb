class JsonTablesController < ApplicationController
  before_action :set_json_table, only: [:show, :update, :destroy]

  # GET /json_tables
  def index
    @json_tables = JsonTable.all

    render json: @json_tables
  end

  # GET /json_tables/1
  def show
    render json: @json_table
  end

  # POST /json_tables
  def create
    @json_table = JsonTable.new(json_table_params)

    if @json_table.save
      render json: @json_table, status: :created, location: @json_table
    else
      render json: @json_table.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /json_tables/1
  def update
    if @json_table.update(json_table_params)
      render json: @json_table
    else
      render json: @json_table.errors, status: :unprocessable_entity
    end
  end

  # DELETE /json_tables/1
  def destroy
    @json_table.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_json_table
      @json_table = JsonTable.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def json_table_params
      request.body.rewind
      @parsed = JSON.parse(request.body.read)
      perm_params = {
        json_file: @parsed
      }
      perm_params
    end
end
