module RailsTaxon::Left
  extend ActiveSupport::Concern

  included do
    Refer.belogns_to :left, class_name: name
    has_many :refers, foreign_key: :left_id
  end

  def valid_lefts
    refer_ids.uniq!

    if (refer_ids & child_ids).present?
      errors.add :refer_ids, 'Parents can not contain children'
    end

    if refer_ids.include? self.id
      errors.add :refer_ids, 'Refers can not contain self'
    end

    add_ids = refer_ids - refer_ids_was.to_a
    add_ids.each do |i|
      unless self.class.exists?(i)
        refer_ids.delete(i)
        logger.info "Invalid parent id: #{i}"
      end
    end
  end

end
