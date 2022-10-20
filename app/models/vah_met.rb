# frozen_string_literal: true

class VahMet < ApplicationRecord
  after_create :complite_datetime

  belongs_to :wafer
  belongs_to :vah_norm

  has_many :vah_met_sites, dependent: :destroy

  scope :not_matched, -> { where(vah_norm_id: nil) }
  scope :with_errors, -> { where(sites_check_sums_count_error: true) }

  def complite_datetime
    splitted_time = self.met_date.split('.')
    year = "20#{splitted_time.last}"
    splitted_time[2] = year
    self.update(datetime: "#{splitted_time.join('.')} #{self.met_time} +3".in_time_zone('Moscow'))
  end
end
