require 'rails_helper'

describe Trail, type: :model do
  describe 'validations' do
    it { should validate_presence_of :length }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }

    it { should validate_numericality_of(:length).only_integer }
    it { should validate_numericality_of(:length).is_greater_than(0) }
  end
  
  describe 'relationships' do
    it { should have_many :water_sources }
  end
  
  describe 'Instance methods' do
    describe '#total_trips' do
      it 'returns the total number of hiking trips that include this trail' do
        trip_1 = Trip.create(name: "CT")
        trip_2 = Trip.create(name: "AT")
        trip_3 = Trip.create(name: "JMT")
        
        trail = Trail.create(name: "Section 1", length: 10, address: "Somewhere", trips: [trip_1, trip_2, trip_3])
        trail_2 = Trail.create(name: "Section 2", length: 12, address: "A Place", trips: [trip_1])
        trail_3 = Trail.create(name: "Section 3", length: 12, address: "A Place", trips: [trip_1, trip_3])
        
        expect(trail.total_trips).to eq(3)
        expect(trail_2.total_trips).to eq(1)
        expect(trail_3.total_trips).to eq(2)
      end
    end
  end
end
