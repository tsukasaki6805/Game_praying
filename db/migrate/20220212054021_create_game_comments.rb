class CreateGameComments < ActiveRecord::Migration[5.2]
  def change
    create_table :game_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
