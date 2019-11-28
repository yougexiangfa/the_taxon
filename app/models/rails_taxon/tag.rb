module RailsTaxon::Tag
  extend ActiveSupport::Concern
  included do
    attribute :name, :string
    attribute :type, :string
    attribute :taggeds_count, :integer, default: 0

    has_many :taggeds, dependent: :delete_all
  end
  
end
