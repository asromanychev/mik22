# frozen_string_literal: true

class Wafer < ApplicationRecord
  after_create :split_lot

  def split_lot
    packet = self.lot.to_s[0...-1].to_i
    order = self.lot.to_s.last.to_i
    self.update(lot_packet: packet, lot_order: order)
  end
end
