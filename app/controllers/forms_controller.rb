class FormsController < ApplicationController
  ALLOWED_ACTIONS_WITHOUT_USER = []

  skip_before_action :authenticate_user, only: ALLOWED_ACTIONS_WITHOUT_USER
  skip_load_and_authorize_resource only: ALLOWED_ACTIONS_WITHOUT_USER

  before_action :set_form, only: [:show, :update, :destroy]

  # GET /forms
  def index
    @forms = Form.all
    
    render json: @forms, each_serializer: Lists::FormSerializer
  end

  # GET /forms/1
  def show
    render json: @form
  end

  # POST /forms
  def create
    @form = Form.new(form_params)

    if @form.save
      render json: @form, status: :created, location: @form
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /forms/1
  def update
    if @form.update(form_params)
      render json: @form
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  # DELETE /forms/1
  def destroy
    @form.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def form_params
      params.require(:form).permit(:title, :start_date, :end_date, sector_ids: [],
        sections_attributes: [
          :name,
          questions_attributes: [
            :title,
            :type,
            :required,
            :max_char,
            :max_value,
            :min_value,
            options: [],
          ]
        ]
      )
    end
end
