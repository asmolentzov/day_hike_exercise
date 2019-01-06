class Trip < ApplicationRecord
  has_many :trip_trails
  has_many :trails, through: :trip_trails
  
  def total_distance
    trails.sum(:length)
  end
  
  def average_distance
    trails.average(:length).round(2)
  end
  
  def longest_trail
    Trail.find_by(length: trails.maximum(:length))
  end
  
  def shortest_trail
    Trail.find_by(length: trails.minimum(:length))
  end
end
