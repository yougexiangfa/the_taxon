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

    belongs_to :parent, class_name: name, foreign_key: :parent_id, optional: true

    before_save :sync_parent, if: -> { parent_id_changed? }
    after_save :define_node!, if: -> { parent_ids_changed? }
    before_destroy :destroy_parent_child
  end

  def relate
    self.class.where(id: relate_ids)
  end

  def children
    self.class.where(id: child_ids)
  end

  def descendant_ids(c_ids = child_ids)
    @descendant_ids ||= c_ids.dup
    get_ids = self.class.where(id: c_ids).pluck(:child_ids).flatten
    if get_ids.present?
      @descendant_ids.concat get_ids
      descendant_ids(get_ids)
    else
      @descendant_ids
    end
  end

  def descendants
    self.class.where(id: descendant_ids)
  end

  def self_and_descendants
    self.class.where(id: descendant_ids + [self.id])
  end

  def ancestor_ids

  end

  def siblings
    self_and_siblings - [self]
  end

  def self_and_siblings(pid = nil)
    if pid
      self.class.find(pid).children
    else
      parent ? parent.children : self.class.root
    end
  end

  def top?
    relate_ids.blank?
  end
  alias :root? :top?

  def middle?
    relate_ids.present? && child_ids.present?
  end

  def bottom?
    child_ids.blank?
  end

  def define_node!
    add_ids = relate_ids - parent_ids_was.to_a
    remove_ids = parent_ids_was.to_a - relate_ids

    self.class.where(id: add_ids).each do |parent|
      parent.child_ids << self.id unless self.id && parent.child_ids.include?(self.id)
      parent.save!
    end

    self.class.where(id: remove_ids).each do |parent|
      parent.child_ids.delete self.id
      parent.save!
    end
  end

  def sync_parent
    relate_ids.delete parent_id_was
    if parent_id && !relate_ids.include?(parent_id)
      relate_ids.unshift(parent_id)
    end
  end

  def destroy_parent_child
    parents.each do |parent|
      parent.child_ids.delete self.id
      parent.save
    end

    children.each do |child|
      child.relate_ids.delete self.id
      child.save
    end
  end

  def reset_child_ids
    self.parents.each do |parent|
      parent.child_ids << self.id unless parent.child_ids.include? self.id
      parent.save
    end
  end

  def invalid_parent_ids
    self.child_ids + [self.id]
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

# 开始属性列表
# :name,           :string,  limit: 50
# :content,        :text,    limit: 65535
# :status,         :integer, default: 0
# :node_type,      :integer
# :children_count, :integer, default: 0
# :logo_id,    :string,  limit: 255

# required fields
# :parent_id
# :relate_ids
# :child_ids