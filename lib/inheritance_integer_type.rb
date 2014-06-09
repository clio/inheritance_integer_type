require "inheritance_integer_type/version"
require "inheritance_integer_type/extensions"

class ActiveRecord::Base
  include InheritanceIntegerType::Extensions
end
