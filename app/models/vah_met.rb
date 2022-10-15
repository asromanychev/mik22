# frozen_string_literal: true

class VahMet < ApplicationRecord
  belongs_to :wafer
  belongs_to :vah_norm
end
