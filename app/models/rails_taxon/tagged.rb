module RailsTaxon::Tagged
  extend ActiveSupport::Concern
  included do
    belongs_to :tagging, polymorphic: true
    belongs_to :tag, counter_cache: true
  end
  
end
