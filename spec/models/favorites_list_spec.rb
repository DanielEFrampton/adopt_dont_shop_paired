require 'rails_helper'

RSpec.describe FavoritesList, type: :model do
before(:each) do
  @favorites_hash = {"1" => true,
                    "2" => true,
                    "3" => true,
                    "4" => true}
  @list_1 = FavoritesList.new(@favorites_hash)
  @list_2 = FavoritesList.new
end

  describe "methods" do
    it "can initialize with attribute containing hash of favorited pet ids and booleans" do
      expect(@list_1.favorited_pets).to eq(@favorites_hash)
    end

    it "can initialize without arguments with default empty hash value" do
      expect(@list_2.favorited_pets).to eq({})
    end

    it 'can return array of ids of favorited pets' do
      expect(@list_1.ids).to eq(%w(1 2 3 4))
    end

    it "it can return total number of favorited pets" do
      expect(@list_1.total_favorites).to eq(4)
      expect(@list_2.total_favorites).to eq(0)
    end
  end
end
