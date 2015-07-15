require "inheritance_integer_type/version"
require "inheritance_integer_type/extensions"

class ActiveRecord::Base

  def self.inherited(child_class)
    child_class.include InheritanceIntegerType::Extensions
    super
  end

end
