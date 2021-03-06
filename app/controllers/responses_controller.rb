class ResponsesController < ApplicationController
  prepend_before_action :set_form_send, only: [:create, :answers]
  before_action :set_form_sector, only: [:create]

  # GET /responses
  def index
    @responses = Response.all
    @responses_filtered = []

    @responses.each do |response|
      @responses_filtered.append({
        "id": response.id,
        "answer": response.answer,
        "fsend": response.fsend,
        "sector_id": response.sector_id,
        "user_sector": response.user.sector_id
      })
    end 

    render json: @responses_filtered
  end

   # PATCH/PUT /responses/1
  def update
    @response = Response.find(params[:id])

    if @response.update(put_params)
      render json: @response
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end

  # POST /responses
  def create
    Response.transaction do
      @responses = Response.create!(responses_params)
      @form_sector.respond!
    end

    render json: @responses
  end

  # GET /responses/forms/form_send_id
  def answers
    if params[:sector_id].present?
      sector = Sector.find(params[:sector_id])
      render json: @form_send, serializer: Sectors::FormSendSerializer, sector: sector
    else
      render json: @form_send
    end
  end

  private

  def set_form_send
    $fsend = params[:form_send_id]
    @form_send = FormSend.find(params[:form_send_id])
  end

  def set_form_sector
    @form_sector = @form_send.form_sectors.find_by(sector_id: @current_user.sector_id)
  end
  
  def current_ability
    @current_ability ||= ResponseAbility.new(@current_user, @form_send)
  end

  def responses_params
    perm_params = params.permit(responses: [:answer, :question_id]).require(:responses)
    perm_params.map { |response| response[:user_id] = @current_user.id }
    perm_params.map { |response| response[:sector_id] = @current_user.sector.id }
    perm_params.map { |response| response[:fsend] = params[:form_send_id] }
    perm_params
  end

  def put_params
    params.require(:response).permit(:answer, :sector_id)
  end
end