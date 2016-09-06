class NodeParentsController < ApplicationController
  before_action :set_node_parent, only: [:show, :edit, :update, :destroy]

  # GET /node_parents
  def index
    @node_parents = NodeParent.all
  end

  # GET /node_parents/1
  def show
  end

  # GET /node_parents/new
  def new
    @node_parent = NodeParent.new
  end

  # GET /node_parents/1/edit
  def edit
  end

  # POST /node_parents
  def create
    @node_parent = NodeParent.new(node_parent_params)

    if @node_parent.save
      redirect_to @node_parent, notice: 'Node parent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /node_parents/1
  def update
    if @node_parent.update(node_parent_params)
      redirect_to @node_parent, notice: 'Node parent was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /node_parents/1
  def destroy
    @node_parent.destroy
    redirect_to node_parents_url, notice: 'Node parent was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_parent
      @node_parent = NodeParent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def node_parent_params
      params.fetch(:node_parent, {})
    end
end
