class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :image_path
      t.timestamps
      t.references :shelter, foreign_key: true
    end
  end
end