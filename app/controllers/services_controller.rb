class ServicesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :get_all_services]
  before_action :set_service, only: [:show, :edit, :update]
  def index
    @services = current_user.services
  end

  def show
  end

  def new
    @service = current_user.services.build
  end

  def create
    # TODO: Save the newly created service. Redirect to an appropriate page if save fails.
    @income = Service.new(service_params)

    respond_to do |format|
      if @income.save
        format.html { redirect_to @income, notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    # TODO: Save the updated service. Redirect to an appropriate page if save fails.
  end

  def get_all_services
    @services = Service.all
  end

  private
  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params[:service][:user_id] = current_user.id
    params.require(:service).permit(:id, :title, :description, :price, :delivery_time, :revisions, :requirements, :created_at, :updated_at,:image, :user_id)
  end

end
