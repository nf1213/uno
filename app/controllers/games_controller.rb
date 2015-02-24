class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @games = Game.all
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    @cards = @game.game_players.find_by_user_id(current_user.id).cards
    @played = Card.find(@game.last_played_id)
  end

  def create
    @game = Game.new
    @player = GamePlayer.new(game: @game, user: current_user)
    if @game.save && @player.save
      @game.deal(7, @player)
      first = @game.find_unowned_cards.shuffle.first
      @game.update(last_played_id: first.id)
      redirect_to @game, notice: "New Game Started"
    else
      render :index
    end
  end

  def play_card
    @game = Game.find(params[:id])
    @card = Card.find(params[:card_id])
    CardOwnership.find_by_game_id_and_card_id(params[:id], params[:card_id]).destroy
    @game.update(last_played_id: @card.id)
    redirect_to @game
  end
end
