class Tagged < ApplicationRecord
  include RailsTaxon::Tagged
end unless defined? Tagged
