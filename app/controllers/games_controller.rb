class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @games = Game.all
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    @cards = @game.game_players.find_by_user_id(current_user.id).cards
  end

  def create
    @game = Game.new
    @player = GamePlayer.new(game: @game, user: current_user)
    if @game.save && @player.save
      @game.deal(7, @player)
      redirect_to @game, notice: "New Game Started"
    else
      render :index
    end
  end

  def play_card
    @game = Game.find(params[:id])
    @card = Card.find(params[:card_id])
    CardOwnership.find_by_game_id_and_card_id(params[:id], params[:card_id]).destroy
    redirect_to @game
  end
end
