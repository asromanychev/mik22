# frozen_string_literal: true

class VahMetSite < ApplicationRecord
  belongs_to :vah_met

  def self.complite_check_sum(frags_values)
    "#{frags_values.keys.count}_#{arr = []; frags_values.each_pair{|k, v| arr << v.count }; arr.join("_")}"
  rescue StandardError => e
    puts 'self.complite_check_sum'
    puts e
  end
end
