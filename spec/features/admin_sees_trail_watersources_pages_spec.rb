require 'rails_helper'

describe 'As an Admin' do
  describe 'when I visit a trail page' do
    it 'shows me a link to edit the trail' do
      admin = User.create(name: 'Admin', password: 'password', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      
      trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere")
      
      ws_1 = WaterSource.create!(name: 'Pond1', mile_marker: 1.5, trail: trail)
      ws_2 = WaterSource.create!(name: 'Bear Creek', mile_marker: 6.0, trail: trail)
      
      visit admin_trail_path(trail)
      
      expect(page).to have_content(trail.name)
      expect(page).to have_content(trail.address)
      
      expect(page).to have_link('Edit Trail')
      click_link('Edit Trail')
      expect(current_path).to eq(edit_admin_trail_path(trail))
    end
    
    it 'shows me a link to the water sources page' do
      admin = User.create(name: 'Admin', password: 'password', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      
      trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere")
      
      ws_1 = WaterSource.create!(name: 'Pond1', mile_marker: 1.5, trail: trail)
      ws_2 = WaterSource.create!(name: 'Bear Creek', mile_marker: 6.0, trail: trail)
      
      visit admin_trail_path(trail)
      
      click_link('Water Sources')
      
      expect(current_path).to eq(admin_trail_water_sources_path(trail))
      
      within "#watersource-#{ws_1.id}" do
        expect(page).to have_content(ws_1.name)
        expect(page).to have_content("Mile Marker: #{ws_1.mile_marker}")
      end
      within "#watersource-#{ws_2.id}" do
        expect(page).to have_content(ws_2.name)
        expect(page).to have_content("Mile Marker: #{ws_2.mile_marker}")
      end
    end
  end
  
  describe 'when I visit a trail water sources page' do
    it 'I can click on links to the individual water source pages' do
      admin = User.create(name: 'Admin', password: 'password', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      
      trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere")
      ws_1 = WaterSource.create!(name: 'Pond1', mile_marker: 1.5, trail: trail)
      
      visit admin_trail_water_sources_path(trail)
      
      within "#watersource-#{ws_1.id}" do
        click_link(ws_1.name)
      end
      expect(current_path).to eq(admin_trail_water_source_path(trail, ws_1))
      expect(page).to have_content(ws_1.name)
      expect(page).to have_content("Mile Marker: #{ws_1.mile_marker}")
    end
  end
  
  describe 'when I visit a trail water source page' do
    it 'lets me edit the water source' do
      admin = User.create(name: 'Admin', password: 'password', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      
      trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere")
      ws_1 = WaterSource.create!(name: 'Pond1', mile_marker: 1.5, trail: trail)
      
      visit admin_trail_water_source_path(trail, ws_1)
      
      expect(page).to have_link('Edit Water Source')
      click_link('Edit Water Source')
      
      expect(current_path).to eq(edit_admin_trail_water_source_path(trail, ws_1))
    end
  end
end