class UniqForPathInVahImports < ActiveRecord::Migration[7.0]
  def change
    change_column :vah_imports, :path, :text, uniq: true, null: false
  end
end
