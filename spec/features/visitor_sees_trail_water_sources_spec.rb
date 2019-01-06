require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit a trails water sources page' do
    it 'each water source name is a link that takes me to that water source page' do
      trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere")
      ws_1 = WaterSource.create!(name: 'Pond1', mile_marker: 1.5, trail: trail)
      ws_2 = WaterSource.create!(name: 'Bear Creek', mile_marker: 6.0, trail: trail)
      
      visit trail_water_sources_path(trail)
      
      within "#watersource-#{ws_1.id}" do
        click_link(ws_1.name)
      end
      
      expect(current_path).to eq(trail_water_source_path(trail, ws_1))
      expect(page).to have_content(ws_1.name)
      expect(page).to have_content("Mile Marker: #{(ws_1.mile_marker)}")
      expect(page).to_not have_content(ws_2.name)
    end
    
    it 'does not let me visit the admin path to water sources' do
      trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere")
      ws_1 = WaterSource.create!(name: 'Pond1', mile_marker: 1.5, trail: trail)
      
      visit admin_trail_water_sources_path(trail)
      
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end