class AddColtoPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :rand, :string
  end
end
