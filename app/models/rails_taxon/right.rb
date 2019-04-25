module RailsTaxon::Right
  extend ActiveSupport::Concern

  included do
    Refer.belogns_to :right, class_name: name
    has_many :refers, foreign_key: :right_id
  end

  def valid_rights
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
