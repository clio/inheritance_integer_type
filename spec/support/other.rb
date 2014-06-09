class Other < ActiveRecord::Base

  has_many :bases, class_name: "Base"

end
