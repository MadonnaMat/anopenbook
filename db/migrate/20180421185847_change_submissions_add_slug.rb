class ChangeSubmissionsAddSlug < ActiveRecord::Migration[5.2]
  def change
    change_table :submissions do |t|
      t.string :slug, null: false
    end

    add_index :submissions, :slug, unique: true
  end
end
