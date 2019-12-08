require 'rails_helper'
# User Story 25, Approved Applications can be revoked


describe "As a visitor" do
  before :each do
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
    @pet_2 = @shelter_1.pets.create(
      name: "Phil",
      approx_age: 1,
      sex: "male",
      image_path: "https://boygeniusreport.files.wordpress.com/2016/11/puppy-dog.jpg",
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
    @application.pets << [@pet_1, @pet_2]
    visit "/applications/#{@application.id}"
    click_link "Approve application for: #{@pet_2.name}"
  end
  describe "After an application has been approved for a pet and I visit application show page"
    describe "I click on the link to unapprove the application" do
      it "And I can see the button to approve the application for that pet again" do
        visit "/applications/#{@application.id}"
        expect(page).not_to have_link "Approve application for: #{@pet_2.name}"

        click_link "Revoke application for: #{@pet_2.name}"

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_link "Approve application for: #{@pet_2.name}"
        expect(page).not_to have_link "Revoke application for: #{@pet_2.name}"
      end
      describe "When I go to that pets show page" do
        it "I can see that the pets adoption status is now back to adoptable and not on hold" do
          visit "/applications/#{@application.id}"
          expect(page).not_to have_link "Approve application for: #{@pet_2.name}"

          click_link "Revoke application for: #{@pet_2.name}"

          visit "/pets/#{@pet_2.id}"

          expect(page).to have_content "Adoptable: adoptable"
          expect(page).not_to have_content "On hold for #{@application.name}"
        end
      end
    end
  end
end
