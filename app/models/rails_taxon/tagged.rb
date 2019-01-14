class Tagged < ApplicationRecord
  belongs_to :tagging, polymorphic: true
  belongs_to :tag, counter_cache: true

end
