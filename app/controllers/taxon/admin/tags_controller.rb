class Taxon::Admin::TagsController < Taxon::Admin::BaseController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params["name-#{I18n.locale}"] = params.dig(:q, :name)
    q_params.merge! params.permit(:type)
    @tags = Tag.default_where(q_params).page(params[:page])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to admin_tags_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_url
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_url
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
