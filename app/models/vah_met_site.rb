# frozen_string_literal: true

class VahMetSite < ApplicationRecord
  before_save :rebuild_check_sum
  belongs_to :vah_import_dat, :class_name => 'VahImport::Dat'
  belongs_to :vah_met

  def rebuild_check_sum
    self.check_sum = "#{self.frags_values.keys.count}_#{arr = []; self.frags_values.each_pair{|_, v| arr << v.count }; arr.join("_")}"
  end
end
