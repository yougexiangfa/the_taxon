class Taxon < ApplicationRecord
  include RailsTaxon::Node
  include RailsTaxon::Taxon
end unless defined? Taxon
