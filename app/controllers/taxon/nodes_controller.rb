class Taxon::NodesController < Taxon::BaseController
  before_action :set_node, only: [:children, :outer, :outer_search]
  skip_before_action :verify_authenticity_token, only: [:children, :outer, :outer_search]

  def children
    @new_node = params[:node_type].constantize.new
  end

  def outer
  end

  def outer_search
    @entity = params[:entity_type].classify.constantize.new
  end

  private
  def set_node
    @node = params[:node_type].constantize.find_by(id: params[:node_id])
  end

end
