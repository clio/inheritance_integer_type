class Base < ActiveRecord::Base
  has_many :belongs_to
  belongs_to :other

  self._inheritance_mapping = {
    1 => "LeftChild",
    2 => "RightChild",
    3 => "DeepChild",
  }
end
