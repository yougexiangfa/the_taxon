class Node < ActiveRecord::Base
  include TheNodeModel

  belongs_to :parent, class_name: 'Node', optional: true


end