require 'rails_helper'

describe 'As a visitor to the site' do
  describe 'when I visit a trail show page' do
    before(:each) do
      @trip_1 = Trip.create(name: "CT")
      @trip_2 = Trip.create(name: "AT")
      @trip_3 = Trip.create(name: "JMT")
      
      @trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere", trips: [@trip_1, @trip_2, @trip_3])
      @trail_2 = Trail.create(name: "Section 2", length: 12, address: "A Place", trips: [@trip_1])
      @trail_3 = Trail.create(name: "Section 3", length: 12, address: "A Place", trips: [@trip_1, @trip_3])
    end
    it 'shows me the name and address of the trail' do
      visit trail_path(@trail)
      expect(page).to have_content(@trail.name)
      expect(page).to have_content(@trail.address)
    end
    
    it 'shows me the name and total length of every hiking trip that includes this trail' do
      visit trail_path(@trail)
      
      within "#trip-#{@trip_1.id}" do
        expect(page).to have_content(@trip_1.name)
        expect(page).to have_content(@trip_1.total_distance)
      end
      within "#trip-#{@trip_2.id}" do
        expect(page).to have_content(@trip_2.name)
        expect(page).to have_content(@trip_2.total_distance)
      end
      within "#trip-#{@trip_3.id}" do
        expect(page).to have_content(@trip_3.name)
        expect(page).to have_content(@trip_3.total_distance)
      end
    end
    
    it 'shows me the total number of hiking trips where this trail was included' do
      visit trail_path(@trail)
      
      expect(page).to have_content("Total number of hiking trips that include this trail: #{@trail.total_trips}")
    end
    
    it 'shows me a link to the water sources' do
      ws_1 = WaterSource.create!(name: 'Pond1', mile_marker: 1.5, trail: @trail)
      ws_2 = WaterSource.create!(name: 'Bear Creek', mile_marker: 6.0, trail: @trail)
      visit trail_path(@trail)
      
      expect(page).to have_link("Water Sources")
      
      click_link("Water Sources")
      # require 'pry'; binding.pry
      expect(current_path).to eq(trail_water_sources_path(@trail))
      within "#watersource-#{ws_1.id}" do
        expect(page).to have_content(ws_1.name)
        expect(page).to have_content("Mile Marker: #{ws_1.mile_marker}")
      end
      within "#watersource-#{ws_2.id}" do
        expect(page).to have_content(ws_2.name)
        expect(page).to have_content("Mile Marker: #{ws_2.mile_marker}")
      end
    end
    
    it 'does not show me a link to edit the page' do
      visit trail_path(@trail)
      
      expect(page).to_not have_content('Edit Trail')
      
      visit admin_trail_path(@trail)
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end