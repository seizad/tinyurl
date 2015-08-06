class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :incoming
      t.string :outgoing
      t.integer :http_status

      t.timestamps null: false
    end
  end
end
