# frozen_string_literal: true

class AddConstraintsToFibonaccis < ActiveRecord::Migration[7.0]
  def change
    change_column :fibonaccis, :position, :integer, null: false
    change_column :fibonaccis, :value, :integer, null: false
    add_index :fibonaccis, :position, unique: true
  end
end
