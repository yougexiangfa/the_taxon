module TheReferModel
  extend ActiveSupport::Concern

  included do
    if connection.adapter_name == 'Mysql2'
      serialize :refer_ids, Array
    end

    if connection.adapter_name == 'PostgreSQL'
      attribute :refer_ids, :integer, array: true, default: []
    end

    validate :valid_refers
  end

  def refers
    self.class.where(id: refer_ids)
  end

  def valid_refers
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