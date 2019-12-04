require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    before :each do
      @shelter = Shelter.create!(
        name: "Ridiculous Test Name",
        address: "124 Fake Ln.",
        city: "Faketown",
        state: "FK",
        zip: "55555")

      @review_1 = @shelter.reviews.create!(
        title: "Great Location",
        rating: 4,
        content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
        image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")

      @review_2 = @shelter.reviews.create!(
        title: "Small store front",
        rating: 2,
        content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

      visit("/shelters/#{@shelter.id}")
    end
    it "I see a link next to each shelter review to delete the review" do

      within "#review-#{@review_1.id}" do
        expect(page).to have_link 'Delete Review'
      end

      within "#review-#{@review_2.id}" do
        expect(page).to have_link 'Delete Review'
      end

    end

    it "When I delete a shelter review I am returned to the shelter's show page and no longer see that review" do
      within "#review-#{@review_2.id}" do
        click_link 'Delete Review'
      end

      expect(current_path).to eq("/shelters/#{@shelter.id}")

      expect(page).to have_css("#review-#{@review_1.id}")
      expect(page).not_to have_css("#review-#{@review_2.id}")

      # double checking ;-)
      expect(page).not_to have_content("Small store front")
    end
  end
end
