class FormsController < ApplicationController
  before_action :set_form, only: [:show, :update, :destroy, :table]

  # GET /forms
  def index
    @forms = Form.all

    params[:sort_by] = "title" unless Form.column_names.include? params[:sort_by]
    params[:sort_direction] = "asc" unless sort_directions.include? params[:sort_direction]

    @forms = @forms.order("#{params[:sort_by]}": :"#{params[:sort_direction]}")
    @forms = @forms.page(params[:page]).per(params[:page_size] || 15) if params[:page].present?

    render json: @forms, each_serializer: Forms::FormSerializer
  end

  # GET /forms/1
  def show
    render json: @form, serializer: Forms::FormSerializer
  end

   # GET /forms/1/form_sends
  def form_sends
    render json: @form, serializer: FormSends::FormSerializer
  end

  # GET /forms/1/table
  def table
    if @current_user.employee?
      render json: @form, serializer: Tables::FormSerializer, sector: @current_user.sector.id
    elsif params[:sector_id].present?
      render json: @form, serializer: Tables::FormSerializer, sector: params[:sector_id]
    else 
      render json: @form, serializer: Tables::FormSerializer
    end
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
      params.require(:form).permit(:title, :description, sector_ids: [],
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
