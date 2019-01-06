class AddTrailToWaterSources < ActiveRecord::Migration[5.1]
  def change
    add_reference :water_sources, :trail, foreign_key: true
  end
end
