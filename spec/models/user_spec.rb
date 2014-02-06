require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"
    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a short password" do
    user = User.create username:"Pekka", password:"moi", password_confirmation:"moi"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with simple password" do
    user = User.create username:"Pekka", password:"moimoimoimoi", password_confirmation:"moimoimoimoi"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user)}
    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings is nil" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 25, 15, 21, user)
      best = create_beer_with_rating(33, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  return beer
end
