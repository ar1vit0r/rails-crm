class CreateLeads < ActiveRecord::Migration[8.1]
  def change
    create_table :leads do |t|
      t.string :title, null: false
      t.text :description
      t.references :contact, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "new", null: false
      t.decimal :value, precision: 10, scale: 2, default: 0
      t.integer :priority, default: 0
      t.date :closes_at

      t.timestamps
    end
  end
end
