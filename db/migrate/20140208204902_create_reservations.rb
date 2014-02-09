class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :party_size
      t.date :date
      t.time :time
      t.integer :restaurant_id
      t.integer :user_id

      t.timestamps
    end
  end
end
