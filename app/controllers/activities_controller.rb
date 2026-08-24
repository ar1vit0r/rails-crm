class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: %i[show edit update destroy]

  def show; end

  def new
    if params[:contact_id]
      @contact = current_user.contacts.find(params[:contact_id])
      @activity = @contact.activities.new(performed_at: Time.current)
      @leads = @contact.leads.order(:title)
    elsif params[:lead_id]
      @lead = current_user.leads.find(params[:lead_id])
      @contact = @lead.contact
      @activity = @lead.activities.new(contact: @contact, performed_at: Time.current)
      @leads = [@lead]
    end
  end

  def create
    if params[:contact_id]
      @contact = current_user.contacts.find(params[:contact_id])
      @activity = @contact.activities.build(activity_params)
      @activity.user = current_user
    elsif params[:lead_id]
      @lead = current_user.leads.find(params[:lead_id])
      @activity = @lead.activities.build(activity_params)
      @activity.contact = @lead.contact
      @activity.user = current_user
    end

    if @activity.save
      redirect_to @activity.contact, notice: "Activity logged!"
    else
      @leads = @activity.contact&.leads&.order(:title) || []
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: "Activity updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    contact = @activity.contact
    @activity.destroy
    redirect_to contact, notice: "Activity deleted!"
  end

  private

  def set_activity
    @activity = current_user.activities.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:kind, :body, :performed_at, :lead_id)
  end
end
