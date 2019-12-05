require 'rails_helper'

RSpec.describe FavoritesList, type: :model do
  describe "methods" do
    it "can initialize with attribute containing array of favorited pet ids" do
      list_1 = FavoritesList.new("1,2,3,4")

      expect(list_1.ids).to eq(['1', '2', '3', '4'])

      list_2 = FavoritesList.new("")

      expect(list_2.ids).to eq([])
    end

    it "it can return total number of favorited pets" do
      list_1 = FavoritesList.new("1,2,3,4")

      expect(list_1.total_favorites).to eq(4)

      list_2 = FavoritesList.new("")

      expect(list_2.total_favorites).to eq(0)
    end
  end
end
