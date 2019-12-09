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
  describe "When I am updating or creating a pet, If I try to submit the form with incomplete information" do
    it "I see a flash message indicating all field(s)" do
      visit "/shelters/#{@shelter_1.id}/pets/new"
      click_button 'Submit'
      expect(page).to have_content("You attempted to submit the form without completing required field(s): Name, Sex, Approximate Age, Description, Image Path")
    end

    # it "I see a flash message indicating which field(s) I am missing" do
    #   visit "/shelters/#{@shelter_1.id}/pets/new"
    #
    #   fill_in 'Name', with: "Phil"
    #   # fill_in 'Sex', with: "male"
    #   fill_in 'Approximate Age', with: "1"
    #   # fill_in 'Description', with: "Very cute"
    #   fill_in 'Image Path', with: "http://files.alfresco.mjh.group/alfresco_images/DVM360//2019/02/27/c23624de-1b4c-4e61-961f-db10dcf27341/veterinary-black-puppy-licking-wood-AdobeStock_211167675-450.jpg"
    #
    #   click_button 'Submit'
    #   expect(page).to have_content("You attempted to submit the form without completing required field(s): Sex, Description")
    #
    # end
  end
end
