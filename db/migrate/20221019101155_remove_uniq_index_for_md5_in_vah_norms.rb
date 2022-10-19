class RemoveUniqIndexForMd5InVahNorms < ActiveRecord::Migration[7.0]
  def change
    remove_index :vah_norms, %i[name is_nors check_md5]
    add_index :vah_norms, %i[name check_md5]
  end
end
