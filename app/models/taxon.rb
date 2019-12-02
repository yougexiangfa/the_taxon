class Taxon < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsTaxon::Taxon
end unless defined? Taxon
