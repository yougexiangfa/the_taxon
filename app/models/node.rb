class Node < ActiveRecord::Base
  has_many :parents, class_name: 'NodeParent', dependent: :destroy
  has_many :children, class_name: 'NodeChild', dependent: :destroy

  # enum
  # node_top => 根节点（无父节点）
  # node_mid => 中间节点（既有父节点，亦有子节点）
  # node_bottom => 底节点（无子节点）
  enum node_type: [
    :node_top,
    :node_mid,
    :node_bottom
  ]
  scope :node_tops, -> { where(node_type: node_types[:node_top]) }



end

# 开始属性列表
# :name,           :string,  limit: 50
# :content,        :text,    limit: 65535
# :status,         :integer, default: 0
# :node_type,      :integer
# :children_count, :integer, default: 0
# :logo_id,    :string,  limit: 255
