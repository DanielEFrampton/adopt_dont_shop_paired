require 'rails_helper'

# User Story 40, More Shelter Statistics

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(
      name: "Great Shelter",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @shelter_2 = Shelter.create(
      name: "Okay Shelter",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @shelter_3 = Shelter.create(
      name: "Mediocrely Reviewed Shelter",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")
    @shelter_4 = Shelter.create(
      name: "Bottom Shelter",
      address: "124 Fake Ln.",
      city: "Faketown",
      state: "FK",
      zip: "55555")

    @review_1 = @shelter_1.reviews.create!(
      title: "Great Location",
      rating: 4,
      content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
      image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")
    @review_2 = @shelter_1.reviews.create!(
      title: "Small store front",
      rating: 2,
      content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

    @review_3 = @shelter_2.reviews.create!(
      title: "Great Location",
      rating: 4,
      content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
      image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")
    @review_4 = @shelter_2.reviews.create!(
      title: "Small store front",
      rating: 1,
      content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

    @review_5 = @shelter_2.reviews.create!(
      title: "Great Location",
      rating: 3,
      content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
      image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")
    @review_6 = @shelter_2.reviews.create!(
      title: "Small store front",
      rating: 1,
      content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

    @review_7 = @shelter_2.reviews.create!(
      title: "Great Location",
      rating: 1,
      content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
      image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")
    @review_8 = @shelter_2.reviews.create!(
      title: "Small store front",
      rating: 2,
      content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")
  end

  describe "When I visit the shelter's index page" do
    it "I see section with top 3 highest (average) rated shelters" do
      visit '/shelters'

      within "#top_shelters" do
        expect(page).to have_content("Top 3 Highest-Rated Shelters")
        # shelter 1 (3), shelter 2 (2.5), shelter 3 (2), shelter 4 (1.5)
        expect(page).to have_link("#{@shelter_1.name} (Average Rating: #{@shelter_1.average_rating})", href: "/shelters/#{@shelter_1}")
        expect(page).to have_link("#{@shelter_1.name} (Average Rating: #{@shelter_2.average_rating})", href: "/shelters/#{@shelter_2}")
        expect(page).to have_link("#{@shelter_1.name} (Average Rating: #{@shelter_3.average_rating})", href: "/shelters/#{@shelter_3}")
      end
    end
  end
end
