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
    @pet_application = PetApplication.create({pet: @pet_1, application: @application})
    @application_2 = @pet_3.applications.create(name: "Ryan the Master Adopter Allen",
                                                address: "123 Street",
                                                city: "College Road",
                                                state: "Colorado",
                                                zip: "80020",
                                                phone_number: "1234567890",
                                                description: "Better than Daniel")
  end

  describe 'When I visit a pets show page' do
    it 'I see a link to view all applications for this pet' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link("Applications For This Pet")
    end
  end

  describe 'When I click that link and applications exist for pet' do
    it 'I see a list of names of applicants for pet linking to application show page' do
      visit "/pets/#{@pet_1.id}"
      click_on("Applications For This Pet")

      expect(current_path).to eq("/pets/#{@pet_1.id}/applications")
      expect(page).to have_link("#{@application.name}", href: "/applications/#{@application.id}")
      expect(page).not_to have_link("#{@application_2.name}")

      visit "/pets/#{@pet_3.id}/applications"
      expect(page).to have_link("#{@application_2.name}", href: "/applications/#{@application_2.id}")
      expect(page).not_to have_link("#{@application.name}")
    end
  end

  describe "When I click that link and applications do not exist for pet" do
    it "I see a message saying applications for that pet don't exist yet" do
      visit "/pets/#{@pet_2.id}"
      click_on("Applications For This Pet")

      expect(page).to have_content("Applications for this pet don't exist yet. :/")
    end
  end
end
