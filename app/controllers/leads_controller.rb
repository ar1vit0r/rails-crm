class LeadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lead, only: %i[show edit update destroy]

  def index
    @leads = current_user.leads.includes(:contact).order(created_at: :desc)
    @leads = @leads.where(status: params[:status]) if params[:status].present?
  end

  def show
    @activities = @lead.activities.includes(:user).order(performed_at: :desc)
  end

  def new
    @lead = current_user.leads.new
    @contacts = current_user.contacts.order(:name)
  end

  def create
    @lead = current_user.leads.build(lead_params)
    if @lead.save
      redirect_to @lead, notice: "Lead created!"
    else
      @contacts = current_user.contacts.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @contacts = current_user.contacts.order(:name)
  end

  def update
    if @lead.update(lead_params)
      redirect_to @lead, notice: "Lead updated!"
    else
      @contacts = current_user.contacts.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lead.destroy
    redirect_to leads_path, notice: "Lead deleted!"
  end

  private

  def set_lead
    @lead = current_user.leads.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:title, :description, :contact_id, :status, :value, :priority, :closes_at)
  end
end
