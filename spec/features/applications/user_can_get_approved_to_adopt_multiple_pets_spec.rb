require 'rails_helper'
#User Story 23, Users can get approved to adopt more than one pet

describe "As a visitor" do
  before :each do
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
    @application = Application.create(
      name: "Daniel The Schmuck Frampton",
      address: "123 Main",
      city: "College Station",
      state: "Texas",
      zip: "80155",
      phone_number: "2014239102",
      description: "nf wkfs. ekwj mqn wka?")
    @application.pets << [@pet_1, @pet_2]
  end
  describe "When an application is made for more than one pet" do
    describe "When I visit that applications show page" do
      it "I'm able to approve the application for any number of pets" do
        visit "/applications/#{@application.id}"

        click_link "Approve application for: #{@pet_1.name}"
        expect(current_path).to eq "/pets/#{@pet_1.id}"

        expect(page).to have_content "Adoptable: pending"
        expect(page).to have_content "On hold for #{@application.name}"

        visit "/applications/#{@application.id}"

        click_link "Approve application for: #{@pet_2.name}"
        expect(current_path).to eq "/pets/#{@pet_2.id}"

        expect(page).to have_content "Adoptable: pending"
        expect(page).to have_content "On hold for #{@application.name}"
      end
    end
  end
end
