module TheNodeModel
  extend ActiveSupport::Concern

  included do
    serialize :parent_ids, Array
    serialize :child_ids, Array

    # enum
    # node_top => 根节点（无父节点）
    # node_mid => 中间节点（既有父节点，亦有子节点）
    # node_bottom => 底节点（无子节点）
    enum node_type: [
      :top,
      :mid,
      :bottom
    ]
  end

  def parents
    self.class.where(id: parent_ids)
  end

  def children
    self.class.where(id: child_ids)
  end

end

# 开始属性列表
# :name,           :string,  limit: 50
# :content,        :text,    limit: 65535
# :status,         :integer, default: 0
# :node_type,      :integer
# :children_count, :integer, default: 0
# :logo_id,    :string,  limit: 255
# :parent_ids
# :child_ids