require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I have not added any pets to my favorites list' do
    describe "And I visit my favorites page ('/favorites')" do
      it 'I see text saying that I have no favorited pets' do
        visit '/favorites'

        expect(page).to have_content("You have not favorited any pets. Visit individual pet pages and click 'Favorite This Pet' to add them here!")
      end
    end
  end
end
