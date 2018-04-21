class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions, id: :uuid do |t|
      t.string :title
      t.text :body
      t.string :type
      t.boolean :voting_enabled
      t.integer :current_step
      t.boolean :final_chapter
      t.boolean :is_included
      t.boolean :frozen
      t.boolean :is_submitted
      t.boolean :in_conflict
      t.references :user, foreign_key: true, type: :uuid
      t.references :book, foreign_key: true, type: :uuid
      t.references :parent, index: true, type: :uuid
      t.integer :parent_version

      t.timestamps
    end
  end
end
