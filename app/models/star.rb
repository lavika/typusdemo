class Star < ActiveRecord::Base
	has_one :user , as: :authable
end
