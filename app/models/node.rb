class Node < ActiveRecord::Base
  has_many :node_parents, dependent: :destroy
  has_many :parents, through: :node_parents
  has_many :node_children, class_name: 'NodeParent', foreign_key: :parent_id
  has_many :children, through: :node_children, source: :child

  has_many :faq_lists

  # enum
  # node_top => 根节点（无父节点）
  # node_mid => 中间节点（既有父节点，亦有子节点）
  # node_bottom => 底节点（无子节点）
  enum node_type: [
    :top,
    :mid,
    :bottom
  ]

  def define_node

  end

end

# 开始属性列表
# :name,           :string,  limit: 50
# :content,        :text,    limit: 65535
# :status,         :integer, default: 0
# :node_type,      :integer
# :children_count, :integer, default: 0
# :logo_id,    :string,  limit: 255
