class Base < ActiveRecord::Base
  include InheritanceIntegerType::Extensions
  
  has_many :belongs_to
  belongs_to :other

end
