class NodeParent < ActiveRecord::Base

  belongs_to :node
  belongs_to :parent, class_name: 'Node', foreign_key: 'parent_id'

end

# :item_id, :integer
# :parent_id, :integer