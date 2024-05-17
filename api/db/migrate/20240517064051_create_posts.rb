class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :category_id
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
