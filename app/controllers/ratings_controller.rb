class RatingsController < ApplicationController

  before_action :set_rating, only: [:show, :edit, :update, :destroy]

  def index
    @ratings = Rating.all
  end

  def new
    @beers = Beer.all
    @rating = Rating.new
  end

  def create
    rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_rating
    @rating = Rating.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def rating_params
    params.require(:rating).permit(:score)
  end
end

