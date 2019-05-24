require "inheritance_integer_type/version"
require "inheritance_integer_type/extensions"

class ActiveRecord::Base
  singleton_class.prepend(InheritanceIntegerType::Extensions)
end
