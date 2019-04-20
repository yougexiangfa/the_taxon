class NodesController < RailsTaxon.config.app_controller.constantize
  before_action :set_node, only: [:children, :outer, :outer_search]
  skip_before_action :verify_authenticity_token, only: [:children, :outer, :outer_search]

  def index
    @nodes = Node.page(params[:page])
  end

  def children
    @new_node = params[:node_type].constantize.new
  end

  def outer
    @entity = params[:entity_type].classify.constantize.new
    if params[:index] && params[:as]
      params[:as].sub! /\[#{params[:index]}\]$/, ''
    end
  end

  def outer_search
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
