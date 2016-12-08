module TheReferenceModel
  extend ActiveSupport::Concern

  included do
    if connection.adapter_name == 'Mysql2'
      serialize :relate_ids, Array
    end

    if connection.adapter_name == 'PostgreSQL'
      attribute :relate_ids, :integer, array: true, default: []
    end

    validate :valid_parents

    before_save :sync_parent, if: -> { parent_id_changed? }
    after_save :define_node!, if: -> { parent_ids_changed? }
    before_destroy :destroy_parent_child
  end

  def relates
    self.class.where(id: relate_ids)
  end

  def sync_parent
    relate_ids.delete parent_id_was
    if parent_id && !relate_ids.include?(parent_id)
      relate_ids.unshift(parent_id)
    end
  end

  def valid_parents
    relate_ids.uniq!

    if (relate_ids & child_ids).present?
      errors.add :relate_ids, 'Parents can not contain children'
    end

    if relate_ids.include? self.id
      errors.add :relate_ids, 'Parents can not contain self'
    end

    add_ids = relate_ids - parent_ids_was.to_a
    add_ids.each do |i|
      unless Node.exists?(i)
        relate_ids.delete(i)
        logger.info "Invalid parent id: #{i}"
      end
    end
  end

end