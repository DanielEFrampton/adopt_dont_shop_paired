require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'I see a favorite indicator in my navigation bar on any page with count of pets in my favorites list' do
    visit '/'

    within('#site-header') do
      expect(page).to have_content('Favorites (0)')
    end

    visit '/pets'

    within('#site-header') do
      expect(page).to have_content('Favorites (0)')
    end

    visit '/shelters'

    within('#site-header') do
      expect(page).to have_content('Favorites (0)')
    end

    visit '/shelters/new'

    within('#site-header') do
      expect(page).to have_content('Favorites (0)')
    end
  end

  it 'I can click on the favorite indicator to be taken to the favorites index page' do
    visit '/'

    click_on('Favorites (0)')

    expect(current_path).to eq('/favorites')
  end
end
