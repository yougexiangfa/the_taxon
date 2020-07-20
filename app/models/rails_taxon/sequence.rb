module RailsTaxon::Sequence
  extend ActiveSupport::Concern

  included do
    attribute :sequence, :integer, default: 1

    after_commit :delete_cache, on: [:create, :destroy]
    after_update_commit :delete_cache, if: -> { saved_change_to_sequence? }

    private
    def delete_cache
      ["sequence/#{self.class.name}"].each do |c|
        Rails.cache.delete(c)
      end
    end
  end

  class_methods do
    def sequences
      Rails.cache.fetch("sequence/#{self.name}") do
        self.select(:sequence).distinct.pluck(:sequence).compact.sort
      end
    end

    def max_sequence
      sequences[-1] || 1
    end

    def min_sequence
      sequences[0] || 1
    end
  end

end
