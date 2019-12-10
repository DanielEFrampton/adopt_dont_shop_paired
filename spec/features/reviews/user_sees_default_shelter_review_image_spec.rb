require 'rails_helper'

# User Story 38, Reviews have a default picture

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I create a review for a shelter' do
    describe 'And do not fill in the field for an image' do
      it 'A default image is used and displayed for that review upon submission' do
        shelter = Shelter.create(name: "Doggy Dreamland",
                                   address: "124 Fake Ln.",
                                   city: "Faketown",
                                   state: "FK",
                                   zip: "55555")

        visit "/shelters/#{shelter.id}/reviews/new"

        fill_in 'Title', with: "Great Location, but..."
        fill_in 'Rating', with: 4
        fill_in 'Content', with: "Smells like dog!"

        click_on 'Submit'

        within "#review-#{shelter.reviews.last.id}" do
          expect(page).to have_css("img[src='https://www.cityofdenton.com/CoD/media/City-of-Denton/Interior%20General%20Content%20Images/6L1A6931-500x333.jpg']")
        end
      end
    end
  end
end
