class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :lead, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :kind, null: false
      t.text :body, null: false
      t.datetime :performed_at, null: false

      t.timestamps
    end
  end
end
