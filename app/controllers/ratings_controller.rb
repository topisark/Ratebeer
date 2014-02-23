class RatingsController < ApplicationController

  before_action :set_rating, only: [:show, :edit, :update, :destroy]

  def index
    @topUsers = Rails.cache.fetch('topusers', expires_in:10.minutes) { User.top(3) }
    @topBreweries = Rails.cache.fetch('topbreweries', expires_in:10.minutes) { Brewery.top(3) }
    @topBeers = Rails.cache.fetch('topbeers', expires_in:10.minutes) { Beer.top(3) }
    @topStyles = Rails.cache.fetch('topstyles', expires_in:10.minutes) { Style.top(3) }
    @ratings = Rails.cache.fetch('ratings', expires_in:10.minutes) { Rating.all }
  end

  def new
    @beers = Beer.all
    @rating = Rating.new
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    if current_user.nil?
      redirect_to signin_path, notice:'You need to be signed in!'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
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

