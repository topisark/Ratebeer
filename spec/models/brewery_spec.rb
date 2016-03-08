require 'spec_helper'

describe Brewery do

  it "without a name is not valid" do
    brewery = Brewery.create  year:1674
    brewery.should_not be_valid
  end
end