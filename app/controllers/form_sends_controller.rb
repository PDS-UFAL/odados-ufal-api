class FormSendsController < ApplicationController
  before_action :set_form_send, only: [:show, :update, :destroy]

  # GET /form_sends
  def index
    @form_sends = FormSend.filter(filter_params)

    status_count = count_status

    params[:sort_by] = "subtitle" unless FormSend.column_names.include? params[:sort_by]
    params[:sort_direction] = "asc" unless sort_directions.include? params[:sort_direction]
    
    @form_sends = @form_sends.order("#{params[:sort_by]}": :"#{params[:sort_direction]}")
    
    @form_sends = @form_sends.page(params[:page]).per(params[:page_size] || 15) if params[:page].present?

    render json: @form_sends, each_serializer: Lists::FormSerializer, meta: meta_info(@form_sends, status_count)
  end

  # GET /form_sends/1
  def show
    if @current_user.employee?
      render json: @form_send, serializer: Employees::FormSerializer, user: @current_user
    else
      render json: @form_send
    end
  end

  # POST /form_sends
  def create
    @form_send = FormSend.new(form_send_params)

    if @form_send.save
      render json: @form_send, status: :created, location: @form_send
    else
      render json: @form_send.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /form_sends/1
  def update
    if @form_send.update(form_send_params)
      render json: @form_send
    else
      render json: @form_send.errors, status: :unprocessable_entity
    end
  end

  # DELETE /form_sends/1
  def destroy
    @form_send.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_send
      @form_send = FormSend.find(params[:id])
    end

    def filter_params
      filter_params = {
        title: params[:title],
        status: params[:status],
        start_date: params[:start_date],
        end_date: params[:end_date],
        range_start_date: params[:range_start_date],
        range_end_date: params[:range_end_date]
      }

      filter_params.merge!(forms_by_sector: @current_user.sector.id) if @current_user.employee?

      filter_params
    end

    def count_status
      status_count = @form_sends.group(:status).count

      status_count = {
        open: status_count['open'] || 0,
        closed: status_count['closed'] || 0,
        not_started: status_count['not_started'] || 0
      }

      status_count
    end

    def meta_info collection, meta_info
      meta_info.merge!(total_pages: collection.total_pages, total_count: collection.total_count) if params[:page].present?

      meta_info
    end

    # Only allow a list of trusted parameters through.
    def form_send_params
      params.require(:form_send).permit(:subtitle, :start_date, :end_date, :form_id, sector_ids: [])
    end
end
