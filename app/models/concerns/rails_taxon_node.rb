module RailsTaxonNode

  def self.prepended(model)
    model.has_closure_tree
    model.attribute :parent_ancestors
    model.before_save :sync_parent_id

    def model.max_depth
      self.hierarchy_class.maximum(:generations).to_i + 1
    end

    def model.extract_multi_attributes(pairs)
      _pairs = pairs.select { |k, _| k.include?('(') }
      _real = {}
      r = self.new.send :extract_callstack_for_multiparameter_attributes, _pairs
      r.each do |k, v|
        _real[k.sub(/ancestors$/, 'id')] = v.values.compact.last
      end
      _real
    end
  end

  def depth_str
    (0..self.class.max_depth - self.depth).to_a.reverse.join
  end

  def sync_parent_id
    _parent_id = self.parent_ancestors&.values.to_a.compact.last
    if _parent_id
      self.parent_id = _parent_id
    end
  end

  def middle?
    parent_id.present? && depth < self.class.max_depth
  end

  def depth
    if parent
      parent.depth + 1
    else
      super
    end
  end

  def sheer_descendant_ids(c_ids = child_ids)
    @sheer_descendant_ids ||= c_ids.dup
    get_ids = self.class.where(parent_id: c_ids).pluck(:id)
    if get_ids.present?
      _get_ids = get_ids - @sheer_descendant_ids
      @sheer_descendant_ids.concat get_ids
      sheer_descendant_ids(_get_ids)
    else
      @sheer_descendant_ids
    end
  end

  def sheer_ancestor_ids
    node, node_ids = self, []
    until (node_ids + [self.id]).include?(node.parent_id)
      node_ids << node.parent_id
      node = node.parent
    end
    node_ids
  end

end

# required fields
# :parent_id
