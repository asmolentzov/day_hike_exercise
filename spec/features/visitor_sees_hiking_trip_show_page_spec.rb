require 'rails_helper'

# when I visit a hiking trip's page,
# I see the average hiking distance
# of all trails on that hiking trip

describe 'As a visitor to the site' do
  describe 'when I visit a hiking trip page' do
    before(:each) do
      @trip = Trip.create(name: "Colorado Trail")
      @trail_1 = @trip.trails.create(length: 16, name: "Section 1", address: "Waterton Canyon")
      
      @trail_2 = @trip.trails.create(length: 10, name: "Section 2", address: "Someplace")
      @trail_3 = @trip.trails.create(length: 12, name: "Section 3", address: "Someplace Else")
    end
    it 'I see information including all the trails on the trip' do
      visit trip_path(@trip)
      
      expect(page).to have_content(@trail_1.name)
      expect(page).to have_content(@trail_1.address)
      expect(page).to have_content("Length: #{@trail_1.length} miles")
      
      expect(page).to have_content(
        @trail_2.name)
      expect(page).to have_content(
        @trail_2.address)
      expect(page).to have_content("Length: #{@trail_2.length} miles")
      
      expect(page).to have_content(@trail_3.name)
      expect(page).to have_content(@trail_3.address)
      expect(page).to have_content("Length: #{@trail_3.length} miles")
    end
    it 'shows me the total hiking distance of all the trails on the trip' do
      visit trip_path(@trip)
      
      expect(page).to have_content("Total distance of trails on trip: #{@trip.total_distance}")
    end
    it 'shows me the average hiking distance of all the trails on the trip' do
      visit trip_path(@trip)
      
      expect(page).to have_content("Average distance of trails on trip: #{@trip.average_distance}")
    end
    it 'shows me the longest trail on trip' do
      visit trip_path(@trip)
      
      expect(page).to have_content("Longest Trail on Trip: #{@trip.longest_trail.name}: #{@trip.longest_trail.length} miles")
    end
    it 'shows me the shortest trail on the trip' do
      visit trip_path(@trip)
      
      expect(page).to have_content("Shortest Trail on Trip: #{@trip.shortest_trail.name}: #{@trip.shortest_trail.length} miles")
    end
    
    it 'all the trail names are links to that trail show page' do
      visit trip_path(@trip)
      
      click_link(@trail_1.name)
      expect(current_path).to eq(trail_path(@trail_1))
      
      visit trip_path(@trip)
      
      click_link(@trail_2.name)
      expect(current_path).to eq(trail_path(@trail_2))
    end
  end
end

# As a visitor,
# when I visit a hiking trip's page,
# I can click on the name of a trail
# to see a show page for that specific trail.