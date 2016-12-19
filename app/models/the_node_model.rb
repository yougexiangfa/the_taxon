module TheNodeModel
  extend ActiveSupport::Concern

  included do
    scope :leaves, -> { where(children_count: 0).where.not(parent_id: nil) }
    scope :roots, -> { where(parent_id: nil) }
    belongs_to :parent, class_name: name, foreign_key: 'parent_id', counter_cache: :children_count, optional: true, inverse_of: :children
    has_many :children, class_name: name, foreign_key: 'parent_id', inverse_of: :parent
  end

  def descendant_ids(c_ids = child_ids)
    @descendant_ids ||= c_ids.dup
    get_ids = self.class.where(parent_id: c_ids).pluck(:id).flatten
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
      parent ? parent.children : self.class.roots
    end
  end

  def root?
    parent_id.nil?
  end

  def middle?
    parent_id.present? && children_count > 0
  end

  def bottom?
    children_count.zero?
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