# frozen_string_literal: true

class VahImportDatLineError < ApplicationRecord
  belongs_to :vah_import_dat, :class_name => 'VahImport::Dat'
end
