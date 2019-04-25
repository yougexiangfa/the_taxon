module RailsTaxon::Tag
  extend ActiveSupport::Concern
  included do
    has_many :taggeds, dependent: :delete_all
  end
  
end
