class ChangeMd5ToStringInVahNorms < ActiveRecord::Migration[7.0]
  def change
    change_column :vah_norms, :check_md5, :string
  end
end
