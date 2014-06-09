class BelongsTo < ActiveRecord::Base

  belongs_to :base
  belongs_to :left_child

end
