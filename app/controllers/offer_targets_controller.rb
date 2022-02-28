class OfferTargetsController < ApplicationController
  before_action :set_offer_target, only: [:edit, :update, :show, :destroy]

  def index
    @offer_targets = OfferTarget.order(offer_id: :asc)
  
    if params[:offer_id].present?
      offer = Offer.find(params[:offer_id])
      @offer_targets = @offer_targets.where(offer: offer)
    end
  end

  def new
    @offer_target = OfferTarget.new
  end

  def create
    @offer_target = OfferTarget.new(offer_target_params)
    if @offer_target.save
      redirect_to offer_targets_path, notice: 'Offer Target Created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @offer_target.update(offer_target_params)
      redirect_to offer_targets_path, notice: 'Offer Target Updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @offer_target.destroy
    redirect_to offer_targets_path, notice: 'Offer Target Destroyed.'
  end


  private

    def set_offer_target
      @offer_target = OfferTarget.find(params[:id])
    end

    def offer_target_params
      params.require(:offer_target).permit(
        :offer_id,
        :min_age,
        :max_age,
        :gender,
        :os,
        :min_os_version,
        :locale
      )
    end

end
