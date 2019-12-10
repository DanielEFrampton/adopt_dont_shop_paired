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
    it {should have_many(:pets).dependent(:destroy)}
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
                                      adoptable: false
                                    })
      @review_1 = @shelter_1.reviews.create!(
        title: "Great Location",
        rating: 4,
        content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
        image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")
      @review_2 = @shelter_1.reviews.create!(
        title: "Small store front",
        rating: 2,
        content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

      @review_3 = @shelter_2.reviews.create!(
        title: "Great Location",
        rating: 10,
        content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
        image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")
      @review_4 = @shelter_2.reviews.create!(
        title: "Small store front",
        rating: 1,
        content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")
      @application = Application.create(
        name: "Daniel The Schmuck Frampton",
        address: "123 Main",
        city: "College Station",
        state: "Texas",
        zip: "80155",
        phone_number: "2014239102",
        description: "nf wkfs. ekwj mqn wka?")
      @application.pets << [@pet_2]

      @shelter_3 = Shelter.create(name: "Yeti Jimmy",
                                 address: "45 Dumpster Fire Alley",
                                 city: "Faketown",
                                 state: "FK",
                                 zip: "55555")

      @review_10 = @shelter_3.reviews.create!(
        title: "Great Location",
        rating: 4,
        content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
        image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")
      @review_11 = @shelter_3.reviews.create!(
        title: "Small store front",
        rating: 2,
        content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

      long_time_ago = Time.new(2015, 1, 1)

      @review_12 = @shelter_3.reviews.create!(
        title: "Big Store Texas",
        rating: 2,
        content: "texas likes to keep em snakes",
        created_at: long_time_ago)
    end

    it "can return pet count for individual shelter" do
      expect(@shelter_1.pet_count).to eq(1)
      expect(@shelter_2.pet_count).to eq(2)
    end

    it "can determine if there is no pending pets that belong to the shelter" do
      expect(@shelter_1.no_pending?).to eq(true)
      expect(@shelter_2.no_pending?).to eq(false)
    end

    it "can return average of all ratings for individual shelter" do
      expect(@shelter_1.average_rating).to eq(3)
      expect(@shelter_2.average_rating).to eq(5.5)
    end

    it "can return number of applications for pets in individual shelter" do
      expect(@shelter_1.application_count).to eq(0)
      expect(@shelter_2.application_count).to eq(1)
      @application.pets << @pet_3
      expect(@shelter_2.application_count).to eq(1)
    end

    it "can sort reviews based off a user requested order" do
      expect(@shelter_3.sort_reviews('highest')).to eq([@review_10, @review_11, @review_12])
      expect(@shelter_3.sort_reviews('lowest')).to eq([@review_12, @review_11, @review_10])
      expect(@shelter_3.sort_reviews(nil)).to eq([@review_10, @review_11, @review_12])
    end
  end
end
