class WaterSource < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :mile_marker
  
  belongs_to :trail
  
end