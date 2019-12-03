require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter's show page" do
    it "I can add a new review for this shelter via link to a form" do
      shelter = Shelter.create!(
        name: "Ridiculous Test Name",
        address: "124 Fake Ln.",
        city: "Faketown",
        state: "FK",
        zip: "55555")

      visit("/shelters/#{shelter.id}")

      click_link('Create New Review')
      expect(current_path).to eq("/shelters/#{shelter.id}/reviews/new")

      fill_in 'Title', with: "Great Location"
      fill_in 'Rating', with: 4
      fill_in 'Content', with: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm"
      fill_in 'Image Path', with: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHrpmj6jvqKicV9ttIunW_Oz_PM-x5RfLsPYYCdAlw6uLf628JxA&s"

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{shelter.id}")

      review = Review.last
      expect(review.title).to eq("Great Location")

      expect(page).to have_content(review.title)
      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.content)
      expect(page).to have_css("img[src *= 'images?q=tbn:ANd9GcRHrpmj6jvqKicV9ttIunW_Oz_PM-x5RfLsPYYCdAlw6uLf628JxA&s']")
    end

    it "Without a Image, I can add a new review for this shelter via link to a form" do 
      shelter = Shelter.create!(
        name: "Ridiculous Test Name",
        address: "124 Fake Ln.",
        city: "Faketown",
        state: "FK",
        zip: "55555")

      visit("/shelters/#{shelter.id}")

      click_link('Create New Review')
      expect(current_path).to eq("/shelters/#{shelter.id}/reviews/new")

      fill_in 'Title', with: "Great Location"
      fill_in 'Rating', with: 4
      fill_in 'Content', with: "3n22 ewlrjwe kej wrkjw nwke nqln qn onrkew 3k iw qm"

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{shelter.id}")

      review = Review.last
      expect(review.title).to eq("Great Location")

      expect(page).to have_content(review.title)
      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.content)
    end
  end
end
