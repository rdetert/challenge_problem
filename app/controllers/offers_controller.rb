class OffersController < ApplicationController
  before_action :set_offer, only: [:edit, :update, :show, :destroy]

  def index
    @offers = Offer.order(title: :asc)

    if params[:min_age].present? && params[:max_age].present?
      @player_payout = Offer.total_payout_for_players_between_ages(params[:min_age], params[:max_age])
    end
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      redirect_to offers_path, notice: 'Offer Created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @offer.update(offer_params)
      redirect_to offers_path, notice: 'Offer Updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @offer.destroy
    redirect_to offers_path, notice: 'Offer Destroyed.'
  end


  private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(
        :player_id,
        :title,
        :header,
        :description,
        :points,
        :payout
      )
    end

end
