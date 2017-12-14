class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.belongs_to :business, index: true
      t.column :classification, :integer, null: false
      t.boolean :scheduled, null: false, default: false
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
