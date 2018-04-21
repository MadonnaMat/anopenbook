class CreateJoinTableUsersBooks < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :books do |t|
      t.index %i[user_id book_id]
      t.index %i[book_id user_id]
    end
  end
end
