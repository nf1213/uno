class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @games = Game.all
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    @cards = Card.all
  end

  def create
    @game = Game.new(player1: current_user)
    if @game.save
      redirect_to @game, notice: "New Game Started"
    else
      render :index
    end
  end
end
