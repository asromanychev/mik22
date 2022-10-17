# frozen_string_literal: true

require 'digest/md5'

class VahNorm < ApplicationRecord
  before_save :rebuild_check_sum
  before_save :rebuild_check_md5

  # search ranges that contain this range "Happy hours that start before my happy hour and end after my happy hour."
  # https://ruk.si/notes/ruby/ruby_on_rails_db_ranges
  scope :cover, -> (datetime) {
    where("date_range @> tsrange(:start, :end)", start: datetime - 1.second, end: datetime + 1.second)
  }

  def rebuild_check_md5
    # https://stackoverflow.com/questions/19380370/is-there-a-quick-and-easy-way-to-create-a-checksum-from-rubys-basic-data-struct
    self.check_md5 = Digest::MD5.hexdigest(Marshal::dump(frags_params))
  end

  def rebuild_check_sum
    self.check_sum = "#{self.frags_params.keys.count}_#{arr = []; self.frags_params.each_pair{|_, v| arr << v.count }; arr.join("_")}"
  end
end
