require 'rails_helper'

# User Story 27, Shelters can be Deleted as long as all pets do not have approved applications on them

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Ridiculous Test Name",
                   address: "124 Fake Ln.",
                   city: "Faketown",
                   state: "FK",
                   zip: "55555")
    @pet_1 = @shelter_1.pets.create({
                             name: "Bill",
                             approx_age: 3,
                             sex: "male",
                             image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
                             description: "Very canine",
                             adoptable: true
                           })
    @pet_2 = @shelter_1.pets.create({
                             name: "Phil",
                             approx_age: 1,
                             sex: "male",
                             image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
                             description: "Very canine",
                             adoptable: true
                           })
    @pet_3 = @shelter_1.pets.create({
                             name: "Philippa",
                             approx_age: 1,
                             sex: "male",
                             image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
                             description: "Very canine",
                             adoptable: true
                           })
    @shelter_2 = Shelter.create(name: "Some Shelter",
                   address: "124 Fake Ln.",
                   city: "Faketown",
                   state: "FK",
                   zip: "55555")
    @pet_4 = @shelter_2.pets.create({
                             name: "Billy",
                             approx_age: 3,
                             sex: "male",
                             image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
                             description: "Very canine",
                             adoptable: true
                           })
    @pet_5 = @shelter_2.pets.create({
                             name: "Philly",
                             approx_age: 1,
                             sex: "male",
                             image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
                             description: "Very canine",
                             adoptable: true
                           })
    @pet_6 = @shelter_2.pets.create({
                             name: "Pip",
                             approx_age: 1,
                             sex: "male",
                             image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
                             description: "Very canine",
                             adoptable: true
                           })
    @application = @pet_1.applications.create({ name: "Daniel The Schmuck Frampton",
                                        address: "123 Main",
                                       city: "College Station",
                                       state: "Texas",
                                       zip: "80155",
                                       phone_number: "2014239102",
                                       description: "nf wkfs. ekwj mqn wka?"
                                      })
    visit "/applications/#{@application.id}"
    click_on "Approve application for: #{@pet_1.name}"
  end

  describe "If a shelter doesn't have any pets with a pending status" do
    it 'I can delete that shelter' do
      visit "/shelters/#{@shelter_2.id}"

      expect(page).to have_link("Delete Shelter")

      visit "/shelters/#{@shelter_1.id}"

      expect(page).not_to have_link("Delete Shelter")


      visit "/shelters"

      within "#shelter-#{@shelter_2.id}-section" do
        expect(page).to have_link("Delete Shelter")
      end

      within "#shelter-#{@shelter_1.id}-section" do
        expect(page).not_to have_link("Delete Shelter")
      end
    end

    it 'when it is deleted all of its pets are deleted as well' do
      visit "/shelters/#{@shelter_2.id}"

      click_on "Delete Shelter"

      expect{Pet.find(@pet_4.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect{Pet.find(@pet_5.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect{Pet.find(@pet_6.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(Pet.count).to eq(3)
    end
  end
end
