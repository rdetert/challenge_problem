class PlayersController < ApplicationController
  before_action :set_player, only: [:update, :show, :destroy]

  def index
    all_players
    @offer_targets = OfferTarget.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    Player.create(player_params)
    respond_to do |format|
      format.json do 
        all_players
        render 'index'
      end
    end
  end

  def update
    @player.update(player_params)
    respond_to do |format|
      format.json do 
        all_players
        render 'index'
      end
    end
  end

  def show
    respond_to do |format|
      format.json
    end
  end

  def destroy
    @player.destroy
    respond_to do |format|
      format.json do 
        all_players
        render 'index'
      end
    end
  end


  private

    def all_players
      @players = Player.order(id: :asc)
    end

    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(
        :first_name,
        :last_name,
        :birthdate,
        :gender
      )
    end

end
