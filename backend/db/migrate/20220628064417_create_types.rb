class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.text :name

      t.timestamps
    end
  end
end
