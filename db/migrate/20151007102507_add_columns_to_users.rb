class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :authable_id, :integer
    add_column :users, :authable_type, :string
  end
end
