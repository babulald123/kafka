class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :status
      t.decimal :total

      t.timestamps
    end
  end
end
