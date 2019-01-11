class Taxon < ApplicationRecord
  acts_as_list

  has_one_attached :cover

  has_translations :name

  scope :hot, -> { order(position: :asc) }

  def cover_url
    cover.service_url if cover.attachment.present?
  end

end
