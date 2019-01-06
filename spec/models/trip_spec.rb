require 'rails_helper'

describe Trip, type: :model do
  describe 'Instance Methods' do
    before(:each) do
      @trip = Trip.create(name: "Colorado Trail")
      @trail_1 = @trip.trails.create(length: 16, name: "Section 1", address: "Waterton Canyon")
      
      @trail_2 = @trip.trails.create(length: 10, name: "Section 2", address: "Someplace")
      @trail_3 = @trip.trails.create(length: 12, name: "Section 3", address: "Someplace Else")
    end
    describe '#total_distance' do
      it 'returns the total distance of all the trails in a trip' do
        total = 38
        expect(@trip.total_distance).to eq(total)
      end
    end
    describe '#average_distance' do
      it 'returns the average distance of all the trails in a trip' do
        average = 12.67
        expect(@trip.average_distance).to eq(average)
      end
    end
    describe '#longest_trail' do
      it 'returns the longest trail in a trip' do
        longest = @trail_1
        
        expect(@trip.longest_trail).to eq(longest)
        
        longest = @trip.trails.create(length: 20, name: "Trail", address: "A Place")
        
        expect(@trip.longest_trail).to eq(longest)
      end
    end
    describe '#shortest_trail' do
      it 'returns the shortest trail on the trip' do
        shortest = @trail_2
        expect(@trip.shortest_trail).to eq(shortest)
        
        shortest = @trip.trails.create(length: 5, name: "Trail", address: "A Place")
        expect(@trip.shortest_trail).to eq(shortest)
      end
    end
  end
end