class ChangeColumnTypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :fibonaccis, :value, :string
  end
end
