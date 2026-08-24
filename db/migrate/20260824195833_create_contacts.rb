class CreateContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.string :company
      t.string :position
      t.string :status, default: "lead", null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
