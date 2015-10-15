class CreateFans < ActiveRecord::Migration
  def change
    create_table :fans do |t|
      t.string :interest

      t.timestamps null: false
    end
  end
end
