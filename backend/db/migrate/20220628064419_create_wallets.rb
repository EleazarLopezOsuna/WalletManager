class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.text :name
      t.boolean :active

      t.timestamps
    end
  end
end
