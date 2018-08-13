class NodesController < ApplicationController
  before_action :set_node, only: [:children, :outer]
  skip_before_action :verify_authenticity_token, only: [:children, :outer]

  def index
    @nodes = Node.page(params[:page])
  end

  def children
    @new_node = params[:node_type].constantize.new
  end

  def outer
    @entity = params[:entity_type].classify.constantize.new
  end

  def new
    @node = Node.new(parent_id: params[:parent_id])
    @options = Node.select(:id, :name).all
  end

  def edit
    @options = Node.select(:id, :name)
  end

  private
  def set_node
    @node = params[:node_type].constantize.find_by(id: params[:node_id])
  end

end
