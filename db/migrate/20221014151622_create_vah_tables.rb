class CreateVahTables < ActiveRecord::Migration[7.0]
  def change
    create_table :vah_mets do |t|
      t.belongs_to :wafer, index: true
      t.belongs_to :vah_norm, index: true

      t.datetime :datetime
      t.string :device # m4
      t.string :operator

      t.timestamps
    end

    add_index :vah_mets, %i[wafer_id datetime device], unique: true

    create_table :vah_met_sites do |t|
      t.belongs_to :vah_met, null: false, index: true
      t.integer :site_number, null: false
      t.jsonb :frags_values, default: {}, null: false
      # frags_values = {
      #   1 => [109.6853,7.9406,45.0948,54.0681,51.4188,22.0595,22.8925,105.4957,383.2518,2.1951,48.9557,63.3816,52.6632,52.7159,27.9827,232.8018,-51.8700,-25.6483,-53.5678,364.7337],
      #   2 => [176.2878,-55.5021,-22.2647,-55.7477,0.6020,34.2144,3.0795,1.5196],
      #   3 => [1377.9617,-12.8525,-14.2553,-11.3293,11.5536,12.2242,-50.6581,57.2793,16.1402,20.0130,4.7937,24.6952,21.8898],
      #   4 => [12.0786,8.7397,190.5862,50.8107,730.8265,178.5174,50.5464,-1.5907,62.5626,403.4381,86.8886,-53.3435,-22.8065,-53.6949],
      #   5 => [3.9467,151.5080,4.3279],
      #   6 => [7.0145,563.9813,225.9833]
      # }
      t.string :check_sum, null: false # высчитывается из frags_values: "6_20_8_13_14_3_3" 6 фрагментов, 20 значений в первом, 8 - во втором ....
      # "#{frags_values.keys.count}_#{arr = []; frags_values.each_pair{|k, v| arr << v.count }; arr.join("_")}"
      t.timestamps
    end

    add_index :vah_met_sites, %i[vah_met_id site_number check_sum], unique: true

    create_table :vah_norms do |t|
      t.string :name, null: false # w_program=KM399;
      t.boolean :is_nors, default: false

      t.integer :check_md5, null: false # https://stackoverflow.com/questions/19380370/is-there-a-quick-and-easy-way-to-create-a-checksum-from-rubys-basic-data-struct
      t.tsrange :range_date
      # надо заиспользовать вычитание диапазонов https://www.rubydoc.info/gems/range_operations/RangeOperations%2FArray.subtract
      t.datetime :start_time # время когда был создан этот норм. Время с которого он начинает работать на измерениях
      # 1. первый норм создается с (13.12.2012 00:01 .. 13.12.2112 00:01)
      # 2. второй норм имеет start_time (к примеру это 15.06.17 13:55)
      # 3. находим период который cover? с start_time
      # - old_norm = all_norm.where(name: new_norm.name).find { |norm| norm.range_date.cover?(new_norm.start_time) }
      # - old_norm.present?
      # - splitted_ranges_array = old_norm.range_date.to_a.insert(1, new_norm.start_time).insert(1, new_norm.start_time - 1.second).to_a.each_slice(2).to_a
      # - if old_norm.start_time > new_norm.start_time
      # -- old_norm.range_date = (splitted_ranges_array.first[0]..splitted_ranges_array.first[1])
      # -- new_norm.range_date = (splitted_ranges_array.last[0]..splitted_ranges_array.last[1])
      # - else
      # -- new_norm.range_date = (splitted_ranges_array.first[0]..splitted_ranges_array.first[1])
      # -- old_norm.range_date = (splitted_ranges_array.last[0]..splitted_ranges_array.last[1])

      t.integer :sites_count, null: false # w_numtq=5;
      t.integer :frags_count, null: false # w_numfr=8;
      t.integer :params_count, null: false # w_param_count=76;
      t.jsonb :frags_params, default: {}, null: false
      # ^B_NLV     ,      , 1, 70.000,160.000, 41;
      # VebNLV    ,     V, 1,  7.700,  8.100, 41;
      # frags_values = {
      #  1 => [
      #        [true, 'B_NLV', '', '1', '70.000', '160.000', '41'],
      #        [false, 'VebNLV', 'V', '1', '7.700', '8.100', '41'],
      #        [false, 'VebNLV', 'V', '1', '7.700', '8.100', '41']
      #       ],
      #  2 => [
      #         [false, 'VebNLV', 'V', '1', '7.700', '8.100', '41'],
      #         [false, 'VebNLV', 'V', '1', '7.700', '8.100', '41'],
      #       ]
      # }
      t.string :check_sum, null: false # высчитывается из frags_params: "5_7_4_3_4_5" 5 фрагментов, 7 параметров в первом, 4 - во втором ....
      # "#{frags_values.keys.count}_#{arr = []; frags_values.each_pair{|k, v| arr << v.count }; arr.join("_")}"

      t.timestamps
    end

    add_index :vah_norms, %i[name is_nors check_md5], unique: true

    create_table :wafers do |t|
      t.string :name # M708-234-9
      t.string :product # M708
      t.integer :lot #234
      t.integer :lot_packet # 23
      t.integer :lot_order # 4
      t.integer :number # 9

      t.timestamps
    end
  end
end
