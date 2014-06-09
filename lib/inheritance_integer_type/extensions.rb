module InheritanceIntegerType
  module Extensions
    extend ActiveSupport::Concern
    module ClassMethods

      def integer_inheritance=(val)
        self._inheritance_mapping[val] = sti_name_without_integer_types
      end

      def find_sti_class(type_name)
        lookup = self._inheritance_mapping[type_name.to_i]
        lookup ? super(lookup) : super
      end

      def sti_name_with_integer_types
        klass = sti_name_without_integer_types
        self._inheritance_mapping.key(klass) || klass
      end


    end

    included do
      class_eval {
        cattr_accessor :_inheritance_mapping
        self._inheritance_mapping = {}
        class << self
          alias_method_chain :sti_name, :integer_types
        end
      }
    end

  end
end
