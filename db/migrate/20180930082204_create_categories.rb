class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :is_tax
      t.boolean :is_fixed
      t.boolean :is_food

      t.timestamps
    end
  end
end
