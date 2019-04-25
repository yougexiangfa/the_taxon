class Taxon < ApplicationRecord
  include RailsTaxon::Taxon
end unless defined? Taxon
