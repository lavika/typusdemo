class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.string :category

      t.timestamps null: false
    end
  end
end
