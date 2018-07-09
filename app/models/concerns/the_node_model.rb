module TheNodeModel
  extend ActiveSupport::Concern

  included do
    has_closure_tree
    attribute :parent_ancestors
    before_save :sync_parent_id
  end

  def depth_str
    (0..self.class.max_depth - self.depth).to_a.reverse.join
  end

  def sync_parent_id
    self.parent_id = self.parent_ancestors&.values.to_a.compact.last
  end

  def middle?
    parent_id.present? && depth < self.class.max_depth
  end

  module ClassMethods

    def max_depth
      self.hierarchy_class.maximum(:generations).to_i + 1
    end

  end


  # def descendant_ids(c_ids = child_ids)
  #   @descendant_ids ||= c_ids.dup
  #   get_ids = self.class.where(parent_id: c_ids).pluck(:id).flatten
  #   if get_ids.present?
  #     @descendant_ids.concat get_ids
  #     descendant_ids(get_ids)
  #   else
  #     @descendant_ids
  #   end
  # end
  #
  # def ancestor_ids
  #   node, node_ids = self, []
  #   while node.parent_id
  #     node_ids << node.parent_id
  #     node = node.parent
  #   end
  #   node_ids.reverse
  # end

end

# required fields
# :parent_id
