class Taxon::Admin::TagsController < Taxon::Admin::BaseController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params["name-#{I18n.locale}"] = params.dig(:q, :name)
    q_params.merge! params.permit(:type)

    @tags = Tag.default_where(q_params).page(params[:page])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    unless @tag.save
      render :new, locals: { model: @tag }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @tag.assign_attributes tag_params

    unless @tag.save
      render :edit, locals: { model: @tag }, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.fetch(:tag, {}).permit(
      :name,
      :type
    )
  end

end
