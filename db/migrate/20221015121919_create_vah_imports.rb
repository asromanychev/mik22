class CreateVahImports < ActiveRecord::Migration[7.0]
  def change
    create_table :vah_imports do |t|
      t.text :type, null: false
      t.text :path, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.text :errors
      t.boolean :successed, default: false

      t.timestamps
    end
  end
end
