module RailsTaxon::Taxon
  extend ActiveSupport::Concern
  included do
    has_closure_tree
    acts_as_list
    has_one_attached :cover
    scope :hot, -> { order(position: :asc) }
  end
  
  def cover_url
    cover.service_url if cover.attachment.present?
  end

end
