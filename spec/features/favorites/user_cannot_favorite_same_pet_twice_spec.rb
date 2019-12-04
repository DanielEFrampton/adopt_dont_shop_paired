require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  before(:each) do
    @shelter = Shelter.create(name: "Ridiculous Test Name",
                   address: "124 Fake Ln.",
                   city: "Faketown",
                   state: "FK",
                   zip: "55555")
    @pet = @shelter.pets.create({
                             name: "Bill",
                             approx_age: 3,
                             sex: "male",
                             image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
                             description: "Very canine",
                             adoptable: true
                           })
  end

  describe "After I've favorited a pet" do
    describe "When I visit that pet's show page" do
      it "I don't see favorite link but one to remove it from favorites" do
        visit "/pets/#{@pet.id}"
        click_on('Favorite This Pet')

        expect(page).not_to have_link('Favorite This Pet')
        expect(page).to have_link('Remove From Favorites')
      end
    end

    describe "When I click that link" do
      it "It is removed from favorites, I'm redirected to pet's page, see flash message, see link to favorite, see indicator decrement" do
        visit "/pets/#{@pet.id}"

        click_on('Favorite This Pet')

        expect(page).to have_content('Favorites (1)')

        click_on('Remove From Favorites')

        expect(current_path).to eq("/pets/#{@pet.id}")
        expect(page).to have_content("This pet has been removed from your favorites. :(")
        expect(page).to have_link('Favorite This Pet')
        expect(page).not_to have_link('Remove From Favorites')
        expect(page).to have_content('Favorites (0)')
      end
    end
  end
end
