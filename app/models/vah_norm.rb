# frozen_string_literal: true

require 'digest/md5'

class VahNorm < ApplicationRecord
  before_save :rebuild_check_sum
  before_save :rebuild_check_md5
  after_create :calculate_range_date

  # search ranges that contain this range "Happy hours that start before my happy hour and end after my happy hour."
  # https://ruk.si/notes/ruby/ruby_on_rails_db_ranges
  scope :cover, -> (datetime) {
    where("range_date @> tsrange(:start, :end)", start: datetime - 1.second, end: datetime + 1.second)
  }

  private
  def copies
    # находим точно такие же копии норм файла. Полное совпадение по md5 и по ТЯ и Названию
    VahNorm.where(check_md5: check_md5, name: name, sites_count: sites_count)
  end

  def calculate_range_date
    covered_version =
      VahNorm.where(name: self.name).where.not(range_date: nil)
             .find { |norm| norm.range_date.cover?(self.start_time) }
    if covered_version.nil?
      # первый норм тут
      self.update(range_date: (DateTime.parse("13.12.2012 00:00 +3")..DateTime.parse("13.12.2112 00:00 +3")))
    else
      # нарезаем range_date
      range_date_to_a = [covered_version.range_date.first, covered_version.range_date.last]

      if covered_version.start_time > self.start_time
        range_before, range_after =
          range_date_to_a
            .insert(1, covered_version.start_time)
            .insert(1, covered_version.start_time - 1.second)
            .to_a.each_slice(2).to_a
        covered_version.update(range_date: range_after)
        self.update(range_date: range_before)
      elsif covered_version.start_time < self.start_time
        range_before, range_after =
          range_date_to_a
            .insert(1, self.start_time)
            .insert(1, self.start_time - 1.second)
            .to_a.each_slice(2).to_a
        covered_version.update(range_date: (range_before.first..range_before.last))
        self.update(range_date: (range_after.first..range_after.last))
      else
        # если covered_version.start_time == self.start_time сохранять в ошибку для дальнейших разберателств
      end
    end
  end

  def rebuild_check_md5
    # https://stackoverflow.com/questions/19380370/is-there-a-quick-and-easy-way-to-create-a-checksum-from-rubys-basic-data-struct
    self.check_md5 = Digest::MD5.hexdigest(Marshal::dump(frags_params))
  end

  def rebuild_check_sum
    self.check_sum = "#{self.frags_params.keys.count}_#{arr = []; self.frags_params.each_pair{|_, v| arr << v.count }; arr.join("_")}"
  end
end
