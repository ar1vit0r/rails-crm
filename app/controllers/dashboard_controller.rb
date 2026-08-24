class DashboardController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def show
    if user_signed_in?
      @total_contacts = current_user.contacts.count
      @total_leads = current_user.leads.count
      @won_leads = current_user.leads.where(status: "won")
      @pipeline_value = @won_leads.sum(:value)
      @conversion_rate = @total_leads > 0 ? (@won_leads.count.to_f / @total_leads * 100).round(1) : 0

      @leads_by_status = current_user.leads.group(:status).count
      @recent_activities = current_user.activities.includes(:contact, :lead).order(performed_at: :desc).limit(10)
    end
  end
end
