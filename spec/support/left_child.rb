class LeftChild < Base

  has_many :duplicate_belongs_to, class_name: "BelongsTo"

  self.integer_inheritance = 1

end
