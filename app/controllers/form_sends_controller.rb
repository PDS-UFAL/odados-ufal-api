class FormSendsController < ApplicationController
  before_action :set_form_send, only: [:show, :update, :destroy]

  # GET /form_sends
  def index
    @form_sends = FormSend.filter(filter_params)
    @form_sends = @form_sends.where("is_history = false OR is_history IS ?", nil) if params[:no_history].present?

    status_count = count_status

    if params[:sort_by].present?
      params[:sort_by] = "subtitle" unless FormSend.column_names.include? params[:sort_by]
      params[:sort_direction] = "asc" unless sort_directions.include? params[:sort_direction]
      @form_sends = @form_sends.order("#{params[:sort_by]}": :"#{params[:sort_direction]}")
      @form_sends = @form_sends.page(params[:page]).per(params[:page_size] || 15) if params[:page].present?
      @meta_info = meta_info(@form_sends, status_count)

      if @form_sends.length == 0
        return render json: "{ \"form_sends\": [] }"
      end

      return render json: @form_sends, each_serializer: Lists::FormSendSerializer, meta: @meta_info
    else
      @form_sends = @form_sends.page(params[:page]).per(params[:page_size] || 15) if params[:page].present?
      @meta_info = meta_info(@form_sends, status_count)
      @form_sends = @form_sends.sort { |a, b| compare(a, b) }

      if @form_sends.length == 0
        return render json: "{ \"form_sends\": [] }"
      end

      return render json: @form_sends, each_serializer: Lists::FormSendSerializer, meta: @meta_info
    end
  end

  # GET /form_sends/1
  def show
    if @current_user.employee?
      render json: @form_send, serializer: Employees::FormSendSerializer, user: @current_user
    else
      render json: @form_send
    end
  end

  # POST /form_sends
  def create
    @form_send = FormSend.new(form_send_params)
    $fsend = @form_send.id
    
    if @form_send.save
      render json: @form_send, status: :created, location: @form_send
    else
      render json: @form_send.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /form_sends/1
  def update
    if @form_send.update(update_form_send_params)
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
    def status_priority status
      if status == "open"
          return 0
      elsif status == "not_started"
        return 1
      end
      return 2
    end

    def compare a, b
      if (status_priority(a.status) <=> status_priority(b.status)) == 0 
        if (a.end_date <=> b.end_date) == 0 
          return (a.subtitle <=> b.subtitle)
        else 
          return (a.end_date <=> b.end_date)
        end
      else 
        return (status_priority(a.status) <=> status_priority(b.status))
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_form_send
      $fsend = params[:id]
      @form_send = FormSend.find(params[:id])
    end

    def filter_params
      filter_params = {
        title: params[:title],
        status: params[:status],
        form_id: params[:form_id],
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

    def update_form_send_params
      perm_params = params.require(:form_send).permit(:subtitle, :year, :start_date, :end_date)
      perm_params
    end

    # Only allow a list of trusted parameters through.
    def form_send_params
      perm_params = params.require(:form_send).permit(:subtitle, :year, :start_date, :end_date, :form_id)

      @form = Form.find(params[:form_send][:form_id])
      perm_params[:sector_ids] = @form.sector_ids
      perm_params[:is_history] = false
      perm_params[:start_date] = perm_params[:start_date].to_datetime
      perm_params[:end_date] = perm_params[:end_date].to_datetime
      perm_params[:start_date] = perm_params[:start_date].beginning_of_day + 3.hours
      perm_params[:end_date] = perm_params[:end_date].end_of_day + 3.hours

      perm_params
    end
end
