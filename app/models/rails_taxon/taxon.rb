module RailsTaxon::Taxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :type, :string
    attribute :color, :string
    attribute :description, :string
    attribute :position, :integer, default: 1
    attribute :entities_count, :integer, default: 0

    has_one_attached :cover

    scope :hot, -> { order(position: :asc) }

    acts_as_list
  end

  def cover_url
    cover.url if cover.attachment.present?
  end

end
