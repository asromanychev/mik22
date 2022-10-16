# frozen_string_literal: true

class VahMet < ApplicationRecord
  after_create :complite_datetime

  belongs_to :wafer
  belongs_to :vah_norm

  has_many :vah_met_sites, dependent: :destroy

  def complite_datetime
    self.update(datetime: DateTime.parse("#{self.met_date} #{self.met_time} +3"))
  end
end
