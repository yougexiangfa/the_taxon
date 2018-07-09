class NodesController < ApplicationController
  before_action :set_node, only: [ :children ]
  skip_before_action :verify_authenticity_token, only: [:children] #todo removed

  def index
    @nodes = Node.page(params[:page])
  end

  def children
    @new_node = params[:node_type].constantize.new
  end

  def outer
    @new_node = params[:outer_type].constantize.new
    @member = Member.new
    if params[:department_id].present?
      @departments = Department.where(parent_id: params[:department_id])
    else
      @departments = Department.none
    end
    @department = @departments.first
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
