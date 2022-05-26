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

  # POST forms/response_history
  def response_history
    if not @current_user.admin?
      return render json: { error: "You are not authorized to access this page." }, status: :unauthorized
    end

    @form = Form.find(params[:form_id])

    if not @form.sector_ids.include?(params[:sector_id])
      return render json: { error: "Sector not included in this form." }, status: :unprocessable_entity
    end

    fsend_params = { 
      subtitle: params[:year].to_s, 
      start_date: Time.current, 
      end_date: Time.current + 1.day, 
      year: params[:year], 
      form_id: params[:form_id], 
      sector_ids: [ params[:sector_id] ]
    }

    fsend = FormSend.create!(fsend_params)

    @form_sector = fsend.form_sectors.find_by(sector_id: params[:sector_id])

    responses = params[:responses]
    responses.map { |response| response[:user_id] = @current_user.id }
    responses.map { |response| response[:sector_id] = params[:sector_id] }
    responses.map { |response| response[:fsend] = fsend.id }
   
    responses_params = []

    responses.each do |response|
      responses_params.append(response.to_enum.to_h)
    end

    Response.transaction do
      @responses = Response.create!(responses_params)
      @form_sector.respond!
    end

    render json: @responses
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
