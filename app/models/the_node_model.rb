module TheNodeModel
  extend ActiveSupport::Concern

  included do
    if connection.adapter_name == 'Mysql2'
      serialize :parent_ids, Array
      serialize :child_ids, Array
      scope :root, -> { where(parent_ids: nil) }
      scope :bottom, -> { where(child_ids: nil).where.not(parent_ids: nil) }
    end

    if connection.adapter_name == 'PostgreSQL'
      attribute :parent_ids, :integer, array: true, default: []
      attribute :child_ids, :integer, array: true, default: []
      scope :root, -> { where(parent_ids: '{}') }
      scope :bottom, -> { where(child_ids: '{}').where.not(parent_ids: '{}') }
    end

    validate :valid_parents

    belongs_to :parent, class_name: name, foreign_key: :parent_id, optional: true

    before_save :sync_parent, if: -> { parent_id_changed? }
    after_save :define_node!, if: -> { parent_ids_changed? }
    before_destroy :destroy_parent_child
  end

  def parents
    self.class.where(id: parent_ids)
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
    parent_ids.blank?
  end
  alias :root? :top?

  def middle?
    parent_ids.present? && child_ids.present?
  end

  def bottom?
    child_ids.blank?
  end

  def define_node!
    add_ids = parent_ids - parent_ids_was.to_a
    remove_ids = parent_ids_was.to_a - parent_ids

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
    parent_ids.delete parent_id_was
    if parent_id && !parent_ids.include?(parent_id)
      parent_ids.unshift(parent_id)
    end
  end

  def destroy_parent_child
    parents.each do |parent|
      parent.child_ids.delete self.id
      parent.save
    end

    children.each do |child|
      child.parent_ids.delete self.id
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
    parent_ids.uniq!

    if (parent_ids & child_ids).present?
      errors.add :parent_ids, 'Parents can not contain children'
    end

    if parent_ids.include? self.id
      errors.add :parent_ids, 'Parents can not contain self'
    end

    add_ids = parent_ids - parent_ids_was.to_a
    add_ids.each do |i|
      unless Node.exists?(i)
        parent_ids.delete(i)
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
# :parent_ids
# :child_ids