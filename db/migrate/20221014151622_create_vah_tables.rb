class CreateMeterings < ActiveRecord::Migration[7.0]
  def change
    create_table :meterings do |t|
      t.integer :wafer_id, default: 0, null: false
      t.integer :program_id, default: 0, null: false
      t.datetime :time
      t.string :device
      t.boolean :xmlflag, default: false, null: false
      t.string :operator, limit: 20
      t.timestamps
    end

    add_index :meterings, :time
    add_index :meterings, :wafer_id
    add_index :meterings, :program_id

    create_table :vah_programs do |t|
      t.string :name, limit: 12
      t.integer :version, limit: 32
    end

    add_index :vah_programs, :name

    create_table :vah_values do |t|
      t.integer   :number_in_site, limit: 6, null: false
      t.decimal   :value, precision: 10, scale: 5, null: false
      t.column    :program_id, :integer, default: 0, null: false
      t.column    :metering_id, :integer, default: 0, null: false
      t.integer   :site, limit: 2, null: false
      t.integer   :frag, limit: 2, null: false
    end

    add_index :vah_values, :program_id
    add_index :vah_values, :metering_id

    create_table :vah_records do |t|
      t.text :notes
      t.datetime :created_on, null: false
    end

    add_column :vah_records, :path_to_source, :string
    add_column :vah_records, :path_to_ignore, :string

    create_table :vah_nors, :force => true do |t|
      t.integer :program_id, null: false
      t.integer :sites_count
      t.integer :frags_count
      t.integer :params_count
    end

    add_index :vah_nors, :program_id

    create_table :vah_nor_params, :force => true do |t|
      t.integer :nor_id, null: false
      t.string :name, limit: 20, default: "", null: false
      t.string :unit, limit: 6, default: "", null: false
      t.integer :order_number, null: false
      t.integer :frag, null: false
      t.decimal :limit_low_c, precision: 10, scale: 5
      t.decimal :limit_high_c, precision: 10, scale: 5
      t.decimal :limit_low_s, precision: 10, scale: 5
      t.decimal :limit_high_s, precision: 10, scale: 5
      t.integer :persent_c
      t.integer :persent_s
      t.boolean :is_rej_c, default: false, null: false
      t.boolean :is_rej_s, default: false, null: false
    end

    add_index :vah_nor_params, :nor_id

    create_table :sessions do |t|
      t.string :session_id, null: false
      t.text :data
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end
end
