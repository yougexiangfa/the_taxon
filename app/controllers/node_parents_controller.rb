class NodeParentsController < ::Admin::BaseController
  before_action :set_node_parent, only: [:show, :edit, :update, :destroy]

  def new
    @node_parent = NodeParent.new
  end

  def edit
  end

  def create
    @node_parent = NodeParent.new(node_parent_params)

    if @node_parent.save
      redirect_to @node_parent, notice: 'Node parent was successfully created.'
    else
      render :new
    end
  end

  def update
    if @node_parent.update(node_parent_params)
      redirect_to @node_parent, notice: 'Node parent was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @node_parent.destroy
    redirect_to node_parents_url, notice: 'Node parent was successfully destroyed.'
  end

  private
  def set_node_parent
    @node_parent = NodeParent.find(params[:id])
  end

  def set_node
    @node = Node.find params[:node_id]
  end

  def node_parent_params
    params.fetch(:node_parent, {})
  end
end
