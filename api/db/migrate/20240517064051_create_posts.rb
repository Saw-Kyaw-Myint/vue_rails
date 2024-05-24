class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.belongs_to :user
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
