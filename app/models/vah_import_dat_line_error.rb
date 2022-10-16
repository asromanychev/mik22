# frozen_string_literal: true

class VahImportDatLineError < ApplicationRecord
  belongs_to :vah_import_dat, :class_name => 'VahImport::Dat'
  validates :vah_import_dat_id, uniqueness: { scope: %i[line_number line] }
end
