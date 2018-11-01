class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.date :books_date
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.boolean :deposit
      t.boolean :transfer
      t.references :category, foreign_key: true
      t.string :summary
      t.integer :amount
      t.boolean :common
      t.boolean :business
      t.boolean :special

      t.timestamps
    end
    add_index :books, [:books_date, :updated_at]
  end
end
