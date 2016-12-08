module TheNodeModel
  extend ActiveSupport::Concern

  included do
    if connection.adapter_name == 'Mysql2'
      serialize :child_ids, Array
      scope :bottom, -> { where(child_ids: nil).where.not(parent_id: nil) }
    end

    if connection.adapter_name == 'PostgreSQL'
      attribute :child_ids, :integer, array: true, default: []
      scope :bottom, -> { where(child_ids: '{}').where.not(parent_id: nil) }
    end

    scope :root, -> { where(parent_id: nil) }
    scope :roots, -> { root }

    belongs_to :parent, class_name: name, foreign_key: 'parent_id', optional: true
    has_many :children, class_name:  name, foreign_key: 'parent_id', inverse_of: :parent

    after_save :define_node!, if: -> { parent_id_changed? }
    before_destroy :destroy_parent_child
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
    node, node_ids = self, []
    while node.parent_id
      node_ids << node.parent_id
      node = node.parent
    end
    node_ids
  end

  def ancestors
    self.class.where(id: ancestor_ids)
  end

  def root
    self.class.find_by(id: ancestor_ids.last)
  end

  def self_and_ancestors
    self.class.where(id: ancestor_ids + [self.id])
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
    parent_id.nil?
  end
  alias :root? :top?

  def middle?
    parent_id.present? && child_ids.present?
  end

  def bottom?
    child_ids.blank?
  end

  def define_node!
    new_parent = self.class.find_by(id: parent_id)
    new_parent.child_ids << self.id unless self.id && new_parent.child_ids.include?(self.id)

    old_parent = self.class.find_by(id: parent_id_was)
    old_parent.child_ids.delete self.id

    new_parent&.save!
    old_parent&.save!
  end

  def destroy_parent_child
    parent.child_ids.delete self.id
    parent.save!
  end

  def reset_child_ids
    self.child_ids = children_ids
    self.save
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