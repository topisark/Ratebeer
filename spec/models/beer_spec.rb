require 'spec_helper'

describe Beer do
  it "is created if it has a name and a style" do
    beer = Beer.create name:"Testbeer", style:"IPA"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not created if it has no name" do
    beer = Beer.create style:"IPA"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not created if it has no style" do
    beer = Beer.create name:"Testiolut"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
