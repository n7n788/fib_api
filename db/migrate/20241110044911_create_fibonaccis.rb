class CreateFibonaccis < ActiveRecord::Migration[7.0]
  def change
    create_table :fibonaccis do |t|
      t.integer :position
      t.integer :value

      t.timestamps
    end
    execute "ALTER TABLE fibonaccis ADD CONSTRAINT position_non_negative CHECK (position >= 0)"
  end
end
