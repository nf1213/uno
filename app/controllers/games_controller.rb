class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :show]
  before_action :get_game, only: [:show, :play_card, :colors, :choose_color]

  def get_game
    @game = Game.find(params[:id])
  end

  def index
    @games = Game.all
    @game = Game.new
  end

  def show
    @cards = @game.game_players.find_by_user_id(current_user.id).cards
    @played = Card.find(@game.last_played_id)
    if @played.value.include?("Wild") && @played.color == "wild"
      redirect_to colors_path, notice: "Chose a color"
    end
    @player = GamePlayer.find_by(game: @game, user: current_user)
    if @game.no_cards_playable?(@player)
      @game.deal(1, @player)
    end
  end

  def create
    @game = Game.new
    @player = GamePlayer.new(game: @game, user: current_user)
    if @game.save && @player.save
      @game.start(@player)
      redirect_to @game, notice: "New Game Started"
    else
      render :index
    end
  end

  def play_card
    @card = Card.find(params[:card_id])
    if @game.can_play?(@card)
      CardOwnership.find_by_game_id_and_card_id(params[:id], params[:card_id]).destroy
      @game.update(last_played_id: @card.id)
      if @card.value.include?("Wild")
        redirect_to colors_path, notice: "Chose a color"
      else
        redirect_to @game, notice: "Card played"
      end
      @game.play_dummies
    else
      redirect_to @game, notice: "Invalid play"
    end
  end

  def colors
  end

  def choose_color
    @color = params[:color]
    wild = Card.find_by_color_and_value(@color, "Wild")
    @game.update(last_played_id: wild.id)
    redirect_to @game
  end
end
