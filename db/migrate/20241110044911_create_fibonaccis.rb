# frozen_string_literal: true

class CreateFibonaccis < ActiveRecord::Migration[7.0]
  def change
    create_table :fibonaccis do |t|
      t.integer :position
      t.integer :value

      t.timestamps
    end
  end
end
