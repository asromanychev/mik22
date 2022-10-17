class AddCheckSumErrorsToVahMets < ActiveRecord::Migration[7.0]
  def change
    add_column :vah_mets, :sites_check_sums_count_error, :boolean, default: false
  end
end
