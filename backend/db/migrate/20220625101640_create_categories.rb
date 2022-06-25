class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.references :type, null: false, foreign_key: true
      t.text :name

      t.timestamps
    end
  end
end
