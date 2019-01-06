class CreateWaterSources < ActiveRecord::Migration[5.1]
  def change
    create_table :water_sources do |t|
      t.string :name
      t.float :mile_marker
    end
  end
end
