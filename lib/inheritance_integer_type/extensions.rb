module InheritanceIntegerType
  module Extensions
    extend ActiveSupport::Concern
    module ClassMethods

      def integer_inheritance=(val)
        self._inheritance_mapping[val] = sti_name_without_integer_types
      end

      def find_sti_class(type_name)
        lookup = self._inheritance_mapping[type_name.to_i]
        if lookup
          if ActiveRecord::VERSION::MAJOR < 5
            super(lookup)
          else
            begin
              if store_full_sti_class
                ActiveSupport::Dependencies.constantize(lookup)
              else
                compute_type(lookup)
              end
            rescue NameError
              raise SubclassNotFound,
                "The single-table inheritance mechanism failed to locate the subclass: '#{type_name}'. " +
                "This error is raised because the column '#{inheritance_column}' is reserved for storing the class in case of inheritance. " +
                "Please rename this column if you didn't intend it to be used for storing the inheritance class " +
                "or overwrite #{name}.inheritance_column to use another column for that information."
            end
          end
        else
          super
        end
      end

      def sti_name_with_integer_types
        klass = sti_name_without_integer_types
        self._inheritance_mapping.key(klass) || klass
      end
    end

    included do
      class << self
        def _inheritance_mapping
          @_inheritance_mapping ||= (superclass == ActiveRecord::Base ? {} : superclass._inheritance_mapping.dup)
        end

        def _inheritance_mapping=(val)
          @_inheritance_mapping = val
        end

        def merge_mapping!(mapping)
          conflicts = _inheritance_mapping.keys & mapping.keys
          raise ArgumentError.new("Duplicate mapping detected for keys: #{conflicts}") if conflicts.any?

          _inheritance_mapping.merge!(mapping)
        end

        alias_method_chain :sti_name, :integer_types
      end
    end

  end
end
