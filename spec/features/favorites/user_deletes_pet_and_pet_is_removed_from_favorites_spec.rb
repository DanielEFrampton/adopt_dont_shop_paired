require 'rails_helper'
# User Story 32, Deleting a pet removes it from favorites

describe "As a visitor" do
  before :each do
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
  describe "If I've added a pet to my favorites" do
    it "When I delete that pet from the database, They are also removed from the favorites list" do
      visit("/pets/#{@pet_1.id}")
      click_on('Favorite This Pet')
      visit("/pets/#{@pet_2.id}")
      click_on('Favorite This Pet')

      visit '/favorites'

      within "#favorite-#{@pet_1.id}" do
        expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
        expect(page).to have_css("img[src *= '#{@pet_1.image_path}']")
      end

      within "#favorite-#{@pet_2.id}" do
        expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")
        expect(page).to have_css("img[src *= '#{@pet_2.image_path}']")
      end

      visit("/pets/#{@pet_1.id}")
      click_on('Delete Pet')

      visit '/favorites'

      expect(page).not_to have_css("#favorite-#{@pet_1.id}")

      within "#favorite-#{@pet_2.id}" do
        expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")
        expect(page).to have_css("img[src *= '#{@pet_2.image_path}']")
      end
    end
  end
end
