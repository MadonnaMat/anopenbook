class ChagneFrozenToIsFrozen < ActiveRecord::Migration[5.2]
  def change
    remove_column :submissions, :frozen
    change_table :submissions do |t|
      t.boolean :is_frozen, default: false
    end
  end
end
