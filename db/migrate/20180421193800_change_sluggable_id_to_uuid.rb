class ChangeSluggableIdToUuid < ActiveRecord::Migration[5.2]
  def change
    remove_index :friendly_id_slugs, :sluggable_id
    remove_column :friendly_id_slugs, :sluggable_id

    change_table :friendly_id_slugs do |t|
      t.uuid :sluggable_id, null: false
    end

    add_index :friendly_id_slugs, :sluggable_id
  end
end
