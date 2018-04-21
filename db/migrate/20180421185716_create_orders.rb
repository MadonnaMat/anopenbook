class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :lulu_id
      t.integer :price
      t.integer :status
      t.references :user, foreign_key: true, type: :uuid
      t.references :book, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
