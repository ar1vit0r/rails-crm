# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.production?
  Rails.logger.warn("Skipping demo user seeds in production.")
else
  User.find_or_create_by!(email: "admin@example.com") do |user|
    user.password = "password"
    user.role = "admin"
  end

  User.find_or_create_by!(email: "user@example.com") do |user|
    user.password = "password"
    user.role = "sales_rep"
  end
end
