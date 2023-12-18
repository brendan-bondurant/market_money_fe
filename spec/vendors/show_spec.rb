require 'rails_helper'

# As a visitor
# When I visit a vendor's show page 'vendors/:id'
# I see that vendor's name, contact information, whether they accept credit, and a description of what they sell

RSpec.describe 'markets#show', type: :feature do
  it 'has the name, contact info, whether or not they accept card, and description' do
    visit vendor_path("55823")
    expect(page).to have_content("The Charcuterie Corner")
    expect(page).to have_content("Vendor selling a variety of artisanal cured meats and sausages.")
    expect(page).to have_content("1-147-179-9747")
    expect(page).to have_content("Credit accepted: false")
  end
  it 'has a search for markets to add to this vendor' do
    visit vendor_path("55823")
    expect(page).to have_content('Search for Markets to add this Vendor')
    expect(page).to have_field('name')
    expect(page).to have_field('city')
    expect(page).to have_field('state')
    expect(page).to have_button('Search Markets')
  end
  it 'can search by city and state' do
    visit vendor_path("54924")
    expect(page).to_not have_content("Del Ray Farmers Market")
    fill_in 'city', with: 'Alexandria'
    fill_in 'state', with: 'Virginia'
    click_button 'Search Markets'
    expect(current_path).to eq(market_search_vendors_path)
    expect(page).to have_link("Del Ray Farmers' Market")
    click_link "Del Ray Farmers' Market"
    expect(current_path).to eq(market_path(324298))
  end
  it 'cannot search by city only' do
    visit vendor_path("54924")
    expect(page).to_not have_content("Del Ray Farmers Market")
    fill_in 'city', with: 'Alexandria'

    click_button 'Search Markets'
    expect(current_path).to eq(market_search_vendors_path)
    expect(page).to have_content("Name or City cannot be sent in on their own. Please provide other parameters to search for markets.")

  end
end