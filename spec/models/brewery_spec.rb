require 'spec_helper'

describe Brewery do

  it "is not valid without a name " do
    brewery = Brewery.create  year:1674
    brewery.should_not be_valid
    expect(Brewery.count).to eq(0)
  end

  it "is not valid without a year " do
    brewery = Brewery.create name:"TestBrewery"
    brewery.should_not be_valid
    expect(Brewery.count).to eq(0)
  end

  it "is not valid with a future year " do
    brewery = Brewery.create name:"TestBrewery", year:2100
    brewery.should_not be_valid
    expect(Brewery.count).to eq(0)
  end

  it "is valid with proper name and year" do
    brewery = Brewery.create name:"TestBrewery", year:1674
    brewery.should be_valid
    expect(Brewery.count).to eq(1)
  end

  describe "top breweries" do

    it "correct brewery is the top brewery when only one has rated beers" do
      brewery1 = Brewery.create name:"Brewery1", year:1674
      create_beer_with_rating_for_brewery(brewery1, 20)
      expect(Brewery.top(1).first).to eq(brewery1)
    end

    it "correct brewery is the top brewery when many have rated beers" do
      brewery1 = Brewery.create name:"Brewery1", year:1674
      brewery2 = Brewery.create name:"Brewery2", year:1674

      create_beer_with_rating_for_brewery(brewery1, 20)
      create_beer_with_rating_for_brewery(brewery2, 40)

      expect(Brewery.top(1).first).to eq(brewery2)
    end

    it "top breweries only returns desired amount of breweries" do
      brewery1 = Brewery.create name:"Brewery1", year:1674
      brewery2 = Brewery.create name:"Brewery2", year:1674
      expect(Brewery.top(1).count).to eq(1)
    end

  end

end