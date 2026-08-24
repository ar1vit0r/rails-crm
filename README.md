# CRM Dashboard

A SaaS-style CRM dashboard built with Rails 8, featuring contact management, lead tracking with pipeline stages, activity logging, and real-time dashboard statistics.

**[Live Demo](https://rails-crm.onrender.com)**

## Highlights

- **Dashboard** — Pipeline stats, conversion rate, leads by status, recent activities
- **Contacts** — CRUD with search/filter by name, company, status
- **Leads** — Pipeline stages (new → qualified → proposal → won/lost), value tracking, priority
- **Activities** — Log interactions (note/call/email/meeting) linked to contacts/leads
- **Roles** — Admin and sales rep roles

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Ruby on Rails 8.1 |
| Language | Ruby 3.4 |
| Database | SQLite (dev) / PostgreSQL (prod) |
| Auth | Devise 5.0 |
| Pagination | Pagy |
| Frontend | Tailwind CSS, Importmap, Hotwire |
| Testing | RSpec, FactoryBot, Shoulda Matchers |
| CI/CD | GitHub Actions |
| Deploy | Docker + Render |

## Quick Start

```bash
git clone https://github.com/ar1vit0r/rails-crm.git
cd rails-crm
bundle install
bin/rails db:create db:migrate db:seed
bin/dev
```

Open [http://localhost:3000](http://localhost:3000).

**Admin login:** `admin@example.com` / `password`
**User login:** `user@example.com` / `password`

## Testing

```bash
bundle exec rspec
# 57 examples, 0 failures
```

## Models

- **User** — Devise auth, roles (admin, sales_rep)
- **Contact** — name, email, phone, company, position, status (lead/prospect/customer)
- **Lead** — title, contact, status (new/qualified/proposal/won/lost), value, priority
- **Activity** — contact, lead (optional), kind (note/call/email/meeting), body

## Skills Demonstrated

- MVC architecture
- RESTful routing
- ActiveRecord associations (4 models)
- Validations
- Authentication (Devise)
- Multi-role authorization
- CRUD operations
- Search and filtering
- Pipeline management
- Activity logging
- Dashboard analytics
- Responsive design (Tailwind)
- Database migrations
- Production deployment
- Test-driven development
- CI/CD pipeline
