class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: %i[show edit update destroy]

  def index
    @contacts = current_user.contacts.order(created_at: :desc)
    @contacts = @contacts.search(params[:search]) if params[:search].present?
    @contacts = @contacts.where(status: params[:status]) if params[:status].present?
  end

  def show
    @activities = @contact.activities.includes(:user, :lead).order(performed_at: :desc)
  end

  def new
    @contact = current_user.contacts.new
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      redirect_to @contact, notice: "Contact created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: "Contact updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: "Contact deleted!"
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :company, :position, :status)
  end
end
