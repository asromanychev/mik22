# frozen_string_literal: true

class Wafer < ApplicationRecord
  after_create :split_lot
  after_create :complite_name

  has_many :vah_mets, dependent: :destroy

  def split_lot
    packet = self.lot.to_s[0...-1].to_i
    order = self.lot.to_s.last.to_i
    self.update(lot_packet: packet, lot_order: order)
  end

  def complite_name
    self.update(name: "#{product}-#{lot}-#{number}")
  end
end
