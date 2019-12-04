require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
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

  describe "When I have added pets to my favorites list" do
    describe "And I visit my favorites page" do
      it "When I click link Adopt Favorited Pets I'm taken to a new application form" do
        visit "/favorites"
        click_link('Adopt Favorited Pets')
        expect(current_path).to eq('/applications/new')
      end

      it "I can select favorited pets for which I'd like this application to apply towards" do
        visit "/applications/new"

        expect(page).to have_unchecked_field(@pet_1.name)
        expect(page).to have_unchecked_field(@pet_2.name)
        expect(page).to_not have_unchecked_field(@pet_3.name)
      end

      describe "When I select one or more pets, and fill in my info, and click sumbit" do
        it "Return to my favorites page, I see a flash message, and no longer see pets I applied for" do
          visit "/applications/new"

          check @pet_2.name

          fill_in "Name", with: "Joe Smoe"
          fill_in "Address", with: "123 Main"
          fill_in "City", with: "College Station"
          fill_in "State", with: "Texas"
          fill_in "Zip", with: "80155"
          fill_in "Phone Number", with: "2014239102"
          fill_in "Describe your qualifications", with: "nf wkfs. ekwj mqn wka?"

          click_button 'Submit'

          # expect(current_path).to eq("/favorites")
          # expect(page).to have_content("Your application for the selected pets has been submitted.")
          #
          # expect(page).not_to have_content(@pet_2.name)
          # expect(page).to have_content(@pet_1.name)
        end
      end
    end
  end
end
