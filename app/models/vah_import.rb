# frozen_string_literal: true

class VahImport < ApplicationRecord
  scope :nor, -> { where(type: 'VahImport::Nor') }
  scope :dat, -> { where(type: 'VahImport::Dat') }
end
