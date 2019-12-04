require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    before :each do
      shelter = Shelter.create!(
        name: "Ridiculous Test Name",
        address: "124 Fake Ln.",
        city: "Faketown",
        state: "FK",
        zip: "55555")

      @review_1 = shelter.reviews.create!(
        title: "Great Location",
        rating: 4,
        content: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm",
        image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")

      @review_2 = shelter.reviews.create!(
        title: "Small store front",
        rating: 2,
        content: "3n2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

      visit("/shelters/#{shelter.id}")
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
    end
  end
end
