require 'rails_helper'

RSpec.describe FavoritesList, type: :model do
before(:each) do
  @favorites_hash = {"1" => true,
                    "2" => true,
                    "3" => true,
                    "4" => true}
  @list_1 = FavoritesList.new(@favorites_hash)
  @list_2 = FavoritesList.new({})
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

    it 'can return whether a given pet_id exists on favorites list' do
      expect(@list_1.favorited?("1")).to eq(true)
      expect(@list_1.favorited?("5")).to eq(false)
    end

    it 'can add a pet_id to its favorites list hash' do
      @list_1.add("5")
      expected_hash = {"1" => true,
                      "2" => true,
                      "3" => true,
                      "4" => true,
                      "5" => true}

      expect(@list_1.favorited?("5")).to eq(true)
      expect(@list_1.favorited_pets).to eq(expected_hash)
      expect(@list_1.favorited_pets["5"]).to eq(true)
    end
  end
end
