class AddUsertoPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :user, :string
  end
end
