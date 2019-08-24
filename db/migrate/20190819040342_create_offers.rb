class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.datetime :game_date
      t.string :area
      t.string :ground
      t.string :memo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
