require 'rails_helper'

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
  end

  describe "When I visit a pet's show page" do
    it 'I see a button or link to favorite that pet' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link('Favorite This Pet')
    end
  end

  describe 'When I click the button or link' do
    it "I'm taken to show page, see flash message, and indicator adds one" do
      visit "/pets/#{@pet_1.id}"

      expect(page).not_to have_content("This pet has been added to your favorites!")
      expect(page).to have_content("Favorites (0)")

      click_on('Favorite This Pet')

      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(page).to have_content("This pet has been added to your favorites!")
      expect(page).to have_content("Favorites (1)")

      visit "/pets/#{@pet_2.id}"

      expect(page).not_to have_content("This pet has been added to your favorites!")
      expect(page).to have_content("Favorites (1)")

      click_on('Favorite This Pet')

      expect(current_path).to eq("/pets/#{@pet_2.id}")
      expect(page).to have_content("This pet has been added to your favorites!")
      expect(page).to have_content("Favorites (2)")
    end
  end
end
