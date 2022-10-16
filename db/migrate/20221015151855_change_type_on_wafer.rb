class ChangeTypeOnWafer < ActiveRecord::Migration[7.0]
  def change
    change_column :wafers, :lot, :string
    change_column :wafers, :lot_packet, :string
    change_column :wafers, :lot_order, :string
    change_column :wafers, :number, :string
  end
end
