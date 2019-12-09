require 'rails_helper'

#User Story 30, Shelter Statistics

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(
      name: "Ridiculous Test Name",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @pet_1 = @shelter_1.pets.create(
      name: "Bill",
      approx_age: 3,
      sex: "male",
      image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
      description: "Very canine",
      adoptable: true)
    @pet_2 = @shelter_1.pets.create(
      name: "Phil",
      approx_age: 1,
      sex: "male",
      image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
      description: "Very canine",
      adoptable: true)
    @shelter_2 = Shelter.create(
      name: "Other Shelter",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @pet_3 = @shelter_2.pets.create(
      name: "Billy",
      approx_age: 3,
      sex: "male",
      image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
      description: "Very canine",
      adoptable: true)
    @application = Application.create(
      name: "Daniel The Schmuck Frampton",
      address: "123 Main",
      city: "College Station",
      state: "Texas",
      zip: "80155",
      phone_number: "2014239102",
      description: "nf wkfs. ekwj mqn wka?")
    @application.pets << [@pet_1, @pet_2]
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
  end

  describe "When I visit a shelter's show page" do
    it 'I see shelter pet count, average rating, number of applications' do
      visit "/shelters/#{@shelter_2.id}"

      expect(page).to have_content("Number of Pets Here: 1")
      expect(page).to have_content("Average Review Rating: 5.5")
      expect(page).to have_content("Applications On File: 0")
    end
  end
end
