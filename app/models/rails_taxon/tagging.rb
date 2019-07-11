module RailsTaxon::Tagging
  extend ActiveSupport::Concern
  included do
    has_many :taggeds, as: :tagging, dependent: :delete_all
    has_many :tags, through: :taggeds
  end
end
