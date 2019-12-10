class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :image_path, default: "https://www.cityofdenton.com/CoD/media/City-of-Denton/Interior%20General%20Content%20Images/6L1A6931-500x333.jpg"
      t.timestamps
      t.references :shelter, foreign_key: true
    end
  end
end
