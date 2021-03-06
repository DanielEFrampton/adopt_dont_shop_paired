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

    it "I see a link to edit the shelter review next to each review." do
      within "#review-#{@review_1.id}" do
        expect(page).to have_link("Edit Review")
      end
      within "#review-#{@review_2.id}" do
        expect(page).to have_link("Edit Review")
      end
    end

    it "I click on this link, I am taken to an edit shelter review path" do
      within "#review-#{@review_1.id}" do
        click_link("Edit Review")
      end

      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
    end
    describe "When I am taken to an edit shelter review path" do
      it "On this new page, I see a form that includes that review's pre populated data" do
        visit("/reviews/#{@review_1.id}/edit")

        expect(find_field('Title').value).to eq(@review_1.title)
        expect(find_field('Rating').value).to eq(@review_1.rating.to_s)
        expect(find_field('Content').value).to eq(@review_1.content)
        expect(find_field('Image Path').value).to eq(@review_1.image_path)

      end

      it "I can update any of these fields, sumbit the form, and see my updated review on shelter's show page" do
        visit("/reviews/#{@review_1.id}/edit")

        fill_in 'Title', with: "Maybe Closed?"
        fill_in 'Rating', with: 3
        fill_in 'Content', with: "Drove by two days in a row, closed sign was up."
        fill_in 'Image Path', with: "https://images.unsplash.com/photo-1535498730771-e735b998cd64?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"

        click_button 'Submit'
        expect(current_path).to eq("/shelters/#{@review_1.shelter.id}")
      end

      describe "When I edit a review and fail to enter a title, rating, or content" do
        it "I see a flash message giving me an error message" do
          visit("/reviews/#{@review_1.id}/edit")
          fill_in 'Title', with: ""

          click_button 'Submit'

          expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
          expect(page).to have_content("Not all required fields have input")
        end
        it "I see a flash message giving me an error message" do
          visit("/reviews/#{@review_1.id}/edit")
          fill_in 'Rating', with: ""

          click_button 'Submit'

          expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
          expect(page).to have_content("Not all required fields have input")
        end
        it "I see a flash message giving me an error message" do
          visit("/reviews/#{@review_1.id}/edit")
          fill_in 'Content', with: ""

          click_button 'Submit'

          expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
          expect(page).to have_content("Not all required fields have input")
        end
      end
    end
  end
end
