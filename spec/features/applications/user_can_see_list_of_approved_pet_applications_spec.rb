require 'rails_helper'

# User Story 37, List of Pets with Approved Applications

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
    @application = Application.create({ name: "Daniel The Schmuck Frampton",
                                        address: "123 Main",
                                       city: "College Station",
                                       state: "Texas",
                                       zip: "80155",
                                       phone_number: "2014239102",
                                       description: "nf wkfs. ekwj mqn wka?"
                                      })
    @pet_application = PetApplication.create({pet_id: @pet_1.id, application_id: @application.id})
    @pet_application = PetApplication.create({pet_id: @pet_2.id, application_id: @application.id})
    visit "/applications/#{@application.id}"
    click_link "Approve application for: #{@pet_1.name}"
  end

  describe 'After an application has been approved for one or more pets' do
    describe 'When I visit the favorites page' do
      it 'I see list of all pets with approved applications linking to pet show pages' do
        visit '/favorites'

        within "#approved_pets" do
          expect(page).to have_link(@pet_1.name, href: "/pets/#{@pet_1.id}")
          expect(page).to have_link(@pet_2.name, href: "/pets/#{@pet_2.id}")
          expect(page).not_to have_link(@pet_3.name)
        end
      end
    end
  end
end
