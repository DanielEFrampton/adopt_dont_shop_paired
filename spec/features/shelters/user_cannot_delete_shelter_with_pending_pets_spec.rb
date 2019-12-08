require 'rails_helper'
# User Story 26, Shelters with Pets that have pending status cannot be Deleted

describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(
      name: "Ridiculous Test Name",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @shelter_2 = Shelter.create(
      name: "Ryan's Snake Adoption Center",
      address: "124 Slitherin Ln.",
      city: "Dtown",
      state: "CO",
      zip: "52225")
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
    @pet_3 = @shelter_2.pets.create(
      name: "Sname",
      approx_age: 10,
      sex: "male",
      image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
      description: "Poison",
      adoptable: true)
    @application = Application.create(
      name: "Daniel The Schmuck Frampton",
      address: "123 Main",
      city: "College Station",
      state: "Texas",
      zip: "80155",
      phone_number: "2014239102",
      description: "nf wkfs. ekwj mqn wka?")
    @application.pets << [@pet_1]
    visit("/applications/#{@application.id}")
    click_link "Approve application for: #{@pet_1.name}"
  end
  describe "If a shelter has approved applications for any of their pets" do
    it "Show Page, I can not delete that shelter(there is no button visible for me to delete the shelter)" do
      visit "/shelters/#{@shelter_1.id}" # no delete button
      expect(page).to have_content(@shelter_1.name)
      within("#navbar-header") do
        expect(page).not_to have_link('Delete Shelter')
      end

      visit "/shelters/#{@shelter_2.id}" # visible delete button
      expect(page).to have_content(@shelter_2.name)
      within("#navbar-header") do
        expect(page).to have_link('Delete Shelter')
      end
    end
    
    it "Index Page, I can not delete that shelter(there is no button visible for me to delete the shelter)" do
      visit "/shelters"
      within "#shelter-#{@shelter_1.id}-section" do
        expect(page).not_to have_link('Delete Shelter')
      end
      within "#shelter-#{@shelter_2.id}-section" do
        expect(page).to have_link('Delete Shelter')
      end
    end
  end
end
