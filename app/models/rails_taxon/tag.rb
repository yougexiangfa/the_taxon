class Tag < ApplicationRecord
  has_many :taggeds, dependent: :delete_all
  has_translations :name

end
