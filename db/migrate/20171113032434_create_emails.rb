# frozen_string_literal: true

class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.belongs_to :business, index: true
      t.column :classification, :integer, null: false
      t.boolean :scheduled, default: false
      t.string :jid
      t.string :subject
      t.text :body
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
