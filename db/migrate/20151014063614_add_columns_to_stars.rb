class AddColumnsToStars < ActiveRecord::Migration
  def change
    add_column :stars, :first_name, :string
    add_column :stars, :last_name, :string
    add_column :stars, :email, :string
  end
end
