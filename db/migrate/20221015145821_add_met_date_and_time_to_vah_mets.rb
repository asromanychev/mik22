class AddMetDateAndTimeToVahMets < ActiveRecord::Migration[7.0]
  def change
    add_column :vah_mets, :met_date, :string
    add_column :vah_mets, :met_time, :string
    add_column :vah_mets, :norm_name, :string
  end
end
