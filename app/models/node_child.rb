class NodeChild < ActiveRecord::Base

  belongs_to :node
  belongs_to :child, class_name: 'Node', foreign_key: 'child_id'

end

# :item_id, :integer
# :child_id, :integer
