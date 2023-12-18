require 'rails_helper'

# As a visitor,
# When I visit '/markets'
# I see all markets listed with their name, city and state
# When I click a button to see more info on that market
# I'm taken to that market's show page '/markets/:id'

RSpec.describe 'markets#index', type: :feature do
  
  it 'lists their name, city, and state' do
    visit markets_path
    expect(page).to have_content("14&U Farmers' Market")
    expect(page).to have_content("Washington")
    expect(page).to have_content("District of Columbia")
    expect(page).to have_button("More Info about 14&U Farmers' Market")
    click_button "More Info about 14&U Farmers' Market"
    expect(current_path).to eq("/markets/322458")
  end
end