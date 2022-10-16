# frozen_string_literal: true

class VahImport
  class Dat < self
    has_many :vah_imports_dat_line_errors,
             :class_name => "VahImportDatLineError",
             foreign_key: 'vah_import_dat_id',
             dependent: :destroy
    has_many :vah_met_sites,
             foreign_key: 'vah_import_dat_id',
             dependent: :destroy
  end
end
