require 'rails_helper'

#User Story 36, All Applicant Names are links to that Applicant's application

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(
      name: "Ridiculous Test Name",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @pet_1 = @shelter_1.pets.create(
      name: "Bill",
      approx_age: 3,
      sex: "male",
      image_path: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg",
      description: "Very canine",
      adoptable: true)
    @application = Application.create(
      name: "Daniel The Schmuck Frampton",
      address: "123 Main",
      city: "College Station",
      state: "Texas",
      zip: "80155",
      phone_number: "2014239102",
      description: "nf wkfs. ekwj mqn wka?")
    @application.pets << [@pet_1]
  end

  describe "Any time I see an applicant's name within this application" do
    it 'It is a link to their application show page' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link("#{@application.name}", href: "/applications/#{@application.id}")
    end

    it 'It is a link to their application show page' do
      visit "/pets/#{@pet_1.id}/applications"

      expect(page).to have_link("#{@application.name}", href: "/applications/#{@application.id}")
    end

    it 'It is a link to their application show page' do
      visit "/applications/#{@application.id}"

      expect(page).to have_link("#{@application.name}", href: "/applications/#{@application.id}")
    end
  end
end
