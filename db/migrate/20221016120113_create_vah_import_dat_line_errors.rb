class CreateVahImportDatLineErrors < ActiveRecord::Migration[7.0]
  def change
    create_table :vah_import_dat_line_errors do |t|
      t.belongs_to :vah_import_dat
      t.integer :line_number, null: false
      t.text :line, null: false

      t.timestamps
    end
  end
end
