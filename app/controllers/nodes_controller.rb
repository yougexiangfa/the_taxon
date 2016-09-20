class NodesController < ::Admin::BaseController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  def index
    @nodes = Node.all
  end

  def top
    @nodes = Node.select(:id, :name).all

    if params[:id]
      @node = Node.find params[:id]
      @nodes = @nodes.where.not(id: @node.invalid_parent_ids)
    end

    render json: { results: @nodes.as_json }
  end

  def show
  end

  def new
    @node = Node.new
  end

  def edit
  end

  def create
    @node = Node.new(node_params)

    if @node.save
      redirect_to nodes_url, notice: 'Node was successfully created.'
    else
      render :new
    end
  end

  def update
    if @node.update(node_params)
      redirect_to nodes_url, notice: 'Node was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @node.destroy
    redirect_to nodes_url, notice: 'Node was successfully destroyed.'
  end

  private
  def set_node
    @node = Node.find(params[:id])
  end

  def node_params
    np = params.fetch(:node, {}).permit(:name, :description, :parent_ids)
    np[:parent_ids] = np[:parent_ids].split(',')
    np
  end
end
