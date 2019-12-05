require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
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
    visit "/pets/#{@pet_1.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_2.id}"
    click_on('Favorite This Pet')
  end

  describe 'When I apply for a pet and fail to fill out any required field' do
    describe 'And I click on a button to submit my application' do
      it "I'm redirect back to the new application and see a flash message" do
        visit "/applications/new"

        find("#checkbox-#{@pet_2.id}").set(true)

        fill_in "Address", with: "123 Main"
        fill_in "City", with: "College Station"
        fill_in "State", with: "Texas"
        fill_in "Zip", with: "80155"
        fill_in "Phone Number", with: "2014239102"
        fill_in "Describe your qualifications", with: "nf wkfs. ekwj mqn wka?"

        click_button 'Submit'

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("You must complete all fields in order to submit the application.")
      end
    end
  end
end
