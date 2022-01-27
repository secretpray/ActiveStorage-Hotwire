class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    # rails g migration AddUserToPosts user:references
    create_table :posts do |t|
      t.string :title, null: false, limit: 120
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
