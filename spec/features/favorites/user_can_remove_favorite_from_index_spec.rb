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

  describe 'When I have added pets to my favorites list' do
    describe "And I visit my favorites page ('/favorites')" do
      it 'Next to each pet, I see a button or link to remove that pet from my favorites' do
        within "#favorite-#{@pet_1.id}" do
          expect(page).to have_link("Remove From Favorites", href: "/favorites/#{@pet_1.id}")
        end

        within "#favorite-#{@pet_2.id}" do
          expect(page).to have_link("Remove From Favorites", href: "/favorites/#{@pet_2.id}")
        end
      end
    end

    describe 'When I click on that button or link to remove a favorite' do
      it "It is removed, I'm redirected to favorites, pet isn't listed, and indicator decremented" do
        expect(page).to have_content('Favorites (2)')

        within "#favorite-#{@pet_1.id}" do
          click_on("Remove From Favorites")
        end

        expect(current_path).to eq("/favorites")
        expect(page).to have_content("This pet has been removed from your favorites. :(")
        expect(page).not_to have_css("#favorite-#{@pet_1.id}")
        expect(page).not_to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
        expect(page).not_to have_css("img[src *= '#{@pet_1.image_path}']")
        expect(page).to have_content('Favorites (1)')
        within "#favorite-#{@pet_2.id}" do
          expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")
          expect(page).to have_css("img[src *= '#{@pet_2.image_path}']")
        end
      end
    end
  end
end
