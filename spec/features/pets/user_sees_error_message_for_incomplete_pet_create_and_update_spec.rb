require 'rails_helper'
# User Story 33, Flash Message for Pet Create and Update

describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create( name: "Ridiculous Test Name",
                                 address: "124 Fake Ln.",
                                 city: "Faketown",
                                 state: "FK",
                                 zip: "55555")
  end
  describe "When I am creating a pet, If I try to submit the form with incomplete information" do
    it "I see a flash message indicating all field(s)" do
      visit "/shelters/#{@shelter_1.id}/pets/new"
      click_button 'Submit'
      expect(page).to have_content("You attempted to submit the form without completing required field(s): Name, Approx_age, Sex, Image_path, Description")
    end

    it "I see a flash message indicating which field(s) I am missing" do
      visit "/shelters/#{@shelter_1.id}/pets/new"

      fill_in 'Name', with: "Phil"
      # fill_in 'Sex', with: "male"
      fill_in 'Approximate Age', with: "1"
      # fill_in 'Description', with: "Very cute"
      fill_in 'Image Path', with: "http://files.alfresco.mjh.group/alfresco_images/DVM360//2019/02/27/c23624de-1b4c-4e61-961f-db10dcf27341/veterinary-black-puppy-licking-wood-AdobeStock_211167675-450.jpg"

      click_button 'Submit'
      expect(page).to have_content("You attempted to submit the form without completing required field(s): Sex, Description")
    end
  end

  describe "When I am updating a pet, If I try to submit the form with incomplete information" do
    it "I see a flash message indiciating which field(s) I am missing" do
      @pet_1 = @shelter_1.pets.create({
                                       name: "Bill",
                                       approx_age: 3,
                                       sex: "male",
                                       image_path: "https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg",
                                       description: "Very canine",
                                       adoptable: true
                                     })
      visit "/pets/#{@pet_1.id}/edit"

      fill_in 'Name', with: ''
      fill_in 'Approximate Age', with: 67
      fill_in 'Sex', with: 'female'
      fill_in 'Description', with: ''
      fill_in 'Image Path', with: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_1280.jpg"

      click_button 'Submit'

      expect(page).to have_content("You attempted to submit the form without completing required field(s): Name, Description")
    end
  end
end
