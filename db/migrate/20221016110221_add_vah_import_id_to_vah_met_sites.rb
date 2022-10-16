class AddVahImportIdToVahMetSites < ActiveRecord::Migration[7.0]
  def change
    add_column :vah_met_sites, :vah_import_dat_id, :integer, null: false
    add_column :vah_met_sites, :line_numbers, :text, array: true, default: []
  end
end
