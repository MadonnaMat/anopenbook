class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books, id: :uuid do |t|
      t.integer :genre
      t.string :title
      t.integer :current_step
      t.datetime :current_step_ends_at
      t.integer :read_count
      t.string :slug, null: :false

      t.timestamps
    end

    add_index :books, :slug, unique: true
  end
end
