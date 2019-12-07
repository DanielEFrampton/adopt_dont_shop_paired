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
    visit "/pets/#{@pet_1.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_2.id}"
    click_on('Favorite This Pet')

    visit '/favorites'
  end

  describe "When I have added pets to my favorites list" do
    describe "And I visit my favorites page ('/favorites')" do
      it "I see a link to remove all favorited pets" do
        expect(page).to have_link('Remove All Favorited Pets')
      end
    end

    describe "When I click that link" do
      it "I'm back at favorites page, see no favorites message, and indicator is 0" do
        click_on('Remove All Favorited Pets')

        expect(current_path).to eq('/favorites')
        expect(page).to have_content("You have removed all pets from your favorites list. ╥﹏╥")
        expect(page).to have_content("You have not favorited any pets. Visit pet pages and click 'Favorite This Pet' to add them here!")
        expect(page).to have_content('Favorites (0)')
      end
    end
  end
end
