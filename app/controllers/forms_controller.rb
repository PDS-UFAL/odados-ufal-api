class FormsController < ApplicationController
  before_action :set_form, only: [:show, :update, :destroy, :table]

  # GET /forms
  def index
    @forms = Form.all

    if params[:sort_by].present?
      params[:sort_by] = "title" unless Form.column_names.include? params[:sort_by]
      params[:sort_direction] = "asc" unless sort_directions.include? params[:sort_direction]
      @forms = @forms.order("#{params[:sort_by]}": :"#{params[:sort_direction]}")
      @forms = @forms.page(params[:page]).per(params[:page_size] || 15) if params[:page].present?
    else 
      @forms = @forms.page(params[:page]).per(params[:page_size] || 15) if params[:page].present?
      @forms = @forms.sort { |a, b| (a.title <=> b.title) == 0 ? (b.created_at <=> a.created_at) : (a.title <=> b.title) }
    end

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

    fsend = FormSend.where(form_id: params[:form_id], year: params[:year], is_history: true)[0]

    if fsend.nil?
      @form = Form.find(params[:form_id])
      fsend_params = { 
        subtitle: params[:year].to_s, 
        start_date: Time.current, 
        end_date: Time.current + 99999.years, 
        year: params[:year], 
        form_id: params[:form_id], 
        sector_ids: @form.sector_ids,
        is_history: true
      }
      fsend = FormSend.create!(fsend_params)
    end

    @form_sector = fsend.form_sectors.find_by(sector_id: params[:sector_id])

    if @form_sector.status != "waiting_response"
      return render json: { error: "This history has already been created" }, status: :unprocessable_entity
    end

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
      render json: @form, serializer: Tables::FormSerializer, sector: params[:sector_id].to_i
    else 
      render json: @form, serializer: Tables::FormSerializer
    end
  end

  # POST /forms
  def create
    @params = form_params

    if @params[:sector_ids].length == 0
      return render json: { error: "Need at least one sector to create a form." }, status: :unprocessable_entity
    end

    @form = Form.new(@params)

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
            :description,
            :max_char,
            :max_value,
            :min_value,
            options: [],
          ]
        ]
      )
    end
end
