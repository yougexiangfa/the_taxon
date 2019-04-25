class Tag < ApplicationRecord
  include RailsTaxon::Tag
end unless defined? Tag
