class FormsController < ApplicationController
  before_action :set_form, only: [:show, :update, :destroy]

  # GET /forms
  def index
    @forms = Form.filter(filter_params)

    status_count = count_status

    params[:sort_by] = "title" unless Form.column_names.include? params[:sort_by]
    params[:sort_direction] = "asc" unless sort_directions.include? params[:sort_direction]
    
    @forms = @forms.order("#{params[:sort_by]}": :"#{params[:sort_direction]}")
    
    @forms = @forms.page(params[:page]).per(params[:page_size] || 15) if params[:page].present?

    render json: @forms, each_serializer: Lists::FormSerializer, meta: meta_info(@forms, status_count)
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

    def filter_params
      filter_params = {
        title: params[:title],
        status: params[:status],
        start_date: params[:start_date],
        end_date: params[:end_date]
      }

      filter_params.merge!(forms_by_sector: @current_user.sector.id) if @current_user.employee?

      filter_params
    end

    def count_status
      status_count = @forms.group(:status).count

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
