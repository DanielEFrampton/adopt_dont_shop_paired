require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many(:reviews).dependent(:destroy)}
  end

  describe "methods" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Ridiculous Test Name",
                                 address: "124 Fake Ln.",
                                 city: "Faketown",
                                 state: "FK",
                                 zip: "55555")
      @shelter_2 = Shelter.create(name: "Even Worse Test Name",
                                 address: "45 Dumpster Fire Alley",
                                 city: "Faketown",
                                 state: "FK",
                                 zip: "55555")
      @pet_1 = @shelter_1.pets.create({
                                      name: "Bill",
                                      approx_age: 3,
                                      sex: "male",
                                      image_path: "http://www.thing.com/image.png",
                                      description: "Very canine",
                                      adoptable: true
                                    })
      @pet_2 = @shelter_2.pets.create({
                                      name: "Jill",
                                      approx_age: 5,
                                      sex: "female",
                                      image_path: "http://www.thing.com/image.png",
                                      description: "Very canine",
                                      adoptable: true
                                    })
      @pet_3 = @shelter_2.pets.create({
                                      name: "Will",
                                      approx_age: 2,
                                      sex: "male",
                                      image_path: "http://www.thing.com/image.png",
                                      description: "Very canine",
                                      adoptable: true
                                    })
    end

    it "can return pet count for individual shelter" do
      expect(@shelter_1.pet_count).to eq(1)
      expect(@shelter_2.pet_count).to eq(2)
    end
  end
end
