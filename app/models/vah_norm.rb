# frozen_string_literal: true

require 'digest/md5'

class VahNorm < ApplicationRecord
  def self.complite_check_md5(frags_values)
    # https://stackoverflow.com/questions/19380370/is-there-a-quick-and-easy-way-to-create-a-checksum-from-rubys-basic-data-struct
    Marshal::dump(frags_values)
    Digest::MD5.hexdigest(Marshal::dump(hash))
  end

  def self.complite_check_sum(frags_values)
    "#{frags_values.keys.count}_#{arr = []; frags_values.each_pair{|k, v| arr << v.count }; arr.join("_")}"
  rescue StandardError => e
    puts 'self.complite_check_sum'
    puts e
  end
end
