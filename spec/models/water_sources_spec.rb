require 'rails_helper'

describe WaterSource, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :mile_marker }
  end
  
  describe 'relationships' do
    it { should belong_to :trail }
  end
end