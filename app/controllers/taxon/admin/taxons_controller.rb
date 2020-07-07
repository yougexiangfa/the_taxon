class Taxon::Admin::TaxonsController < Taxon::Admin::BaseController
  before_action :set_taxon, only: [:show, :edit, :update, :destroy]

  def index
    q_params = params.permit(:type)
    @taxons = Taxon.with_attached_cover.default_where(q_params).order(position: :asc).page(params[:page])
  end

  def new
    @taxon = Taxon.new
  end

  def create
    @taxon = Taxon.new(taxon_params)

    unless @taxon.save
      render :new, locals: { model: @taxon }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @taxon.update(taxon_params)

    unless
      render :edit, locals: { model: @taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @taxon.destroy
  end

  private
  def set_taxon
    @taxon = Taxon.find(params[:id])
  end

  def taxon_params
    params.fetch(:taxon, {}).permit(
      :name,
      :description,
      :position,
      :color,
      :cover,
      :type
    )
  end

end
