require 'rails_helper'

# when I visit the hiking trips index page,
# and I click on the name of a hiking trip,
# I see a unique page for that hiking trip.

describe 'As a visitor to the site' do
  describe 'when I visit the hiking trips index page' do
    it 'should show all hiking trips' do
      trip_1 = Trip.create(name: "Colorado Trail")
      trip_2 = Trip.create(name: "Long Trail")
      trip_3 = Trip.create(name: "John Muir Trail")
      
      visit trips_path
      
      expect(page).to have_content(trip_1.name)
      expect(page).to have_content(trip_2.name)
      expect(page).to have_content(trip_3.name)
    end
    it 'should have all hiking trip names be links to that trip' do
      trip_1 = Trip.create(name: "Colorado Trail")
      trip_2 = Trip.create(name: "Long Trail")
      trip_3 = Trip.create(name: "John Muir Trail")
      
      visit trips_path
      
      expect(page).to have_link(trip_1.name)
      expect(page).to have_link(trip_2.name)
      expect(page).to have_link(trip_3.name)
      
      click_link(trip_1.name)
      expect(current_path).to eq(trip_path(trip_1))
      
      visit trips_path
      click_link(trip_2.name)
      expect(current_path).to eq(trip_path(trip_2))
    end
  end
end