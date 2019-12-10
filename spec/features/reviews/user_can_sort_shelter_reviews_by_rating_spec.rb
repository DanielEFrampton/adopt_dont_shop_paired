require 'rails_helper'
# User Story 39, Sortable Reviews

describe "As a visitor," do
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

    @review_3 = @shelter.reviews.create!(
      title: "yeti makes nice bottles",
      rating: 4,
      content: "As you read before this is not a test review",
      image_path: "https://www.shutterstock.com/image-vector/location-pin-700686334")

    @review_4 = @shelter.reviews.create!(
      title: "Great Snake Place",
      rating: 5,
      content: "fewfwe k32 then a snake eat my toe 2 ww q2 ewlrjwe ke wrkw qw jw nwke 23 2nqln qn onrkew 3k iw dqqm")

    end
  describe "When I visit a shelter's show page to see their reviews," do
    it "I see additional links to sort their reviews by highest rating, then by descending date" do
      visit "/shelters/#{@shelter.id}"
      click_link('Sort by Highest Rating')
      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page.body.index(@review_4.title)).to be < page.body.index(@review_1.title)
      expect(page.body.index(@review_4.title)).to be < page.body.index(@review_2.title)
      expect(page.body.index(@review_4.title)).to be < page.body.index(@review_3.title)
      expect(page.body.index(@review_3.title)).to be < page.body.index(@review_2.title)
      expect(page.body.index(@review_3.title)).to be < page.body.index(@review_1.title)
      expect(page.body.index(@review_1.title)).to be < page.body.index(@review_2.title)

    end
    it "I see additional links to sort their sort reviews by lowest rating, then by ascending date" do
      visit "/shelters/#{@shelter.id}"

      click_link('Sort by Lowest Rating')

      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page.body.index(@review_2.title)).to be < page.body.index(@review_4.title)
      expect(page.body.index(@review_2.title)).to be < page.body.index(@review_3.title)
      expect(page.body.index(@review_2.title)).to be < page.body.index(@review_1.title)
      expect(page.body.index(@review_1.title)).to be < page.body.index(@review_3.title)
      expect(page.body.index(@review_1.title)).to be < page.body.index(@review_4.title)
      expect(page.body.index(@review_3.title)).to be < page.body.index(@review_4.title)
    end
  end
end
