require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    it "I see a list of reviews for that shelter" do
      shelter = Shelter.create!(
        name: "Ridiculous Test Name",
        address: "124 Fake Ln.",
        city: "Faketown",
        state: "FK",
        zip: "55555")

      review_1 = shelter.reviews.create!(
        title: "Great Location",
        rating: 4,
        content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
        image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")

      review_2 = shelter.reviews.create!(
        title: "Small store front",
        rating: 2,
        content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

      visit("/shelters/#{shelter.id}")

      within "#review-#{review_1.id}" do
        expect(page).to have_content("Great Location")
        expect(page).to have_content("4")
        expect(page).to have_content("3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm")
        expect(page).to have_css("img[src *= 'location-pin-700686334']")
      end

      within "#review-#{review_2.id}" do
        expect(page).to have_content(review_2.title)
        expect(page).to have_content(review_2.rating)
        expect(page).to have_content(review_2.content)
      end

    end
  end
end
