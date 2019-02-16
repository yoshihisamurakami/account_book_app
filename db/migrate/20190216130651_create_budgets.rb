class CreateBudgets < ActiveRecord::Migration[5.1]
  def change
    create_table :budgets do |t|
      t.integer :target_year
      t.integer :target_month
      t.integer :regular_income
      t.integer :extra_income
      t.integer :special_income
      t.integer :tax_funding
      t.integer :special_funding
      t.integer :savings
      t.integer :fixed_budget

      t.timestamps
    end
  end
end
