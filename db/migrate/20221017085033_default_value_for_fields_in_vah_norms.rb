class DefaultValueForFieldsInVahNorms < ActiveRecord::Migration[7.0]
  def change
    change_column :vah_norms, :sites_count, :integer, default: 0
    change_column :vah_norms, :frags_count, :integer, default: 0
    change_column :vah_norms, :params_count, :integer, default: 0
  end
end
