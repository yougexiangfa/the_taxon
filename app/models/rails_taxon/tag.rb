class Tag < ApplicationRecord
  has_many :taggeds, dependent: :delete_all

end
