class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.text :description
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
