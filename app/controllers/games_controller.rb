class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @games = Game.all
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    @cards = current_user.cards
  end

  def create
    @game = Game.new(player1: current_user)
    if @game.save
      @game.deal(7, current_user)
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
