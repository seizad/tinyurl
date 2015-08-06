class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :event
      t.references :url, index: true

      t.timestamps null: false
    end
    add_foreign_key :stats, :urls
  end
end
