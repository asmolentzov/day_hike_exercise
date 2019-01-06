class TripTrail < ApplicationRecord
  belongs_to :trip
  belongs_to :trail
end