require 'spec_helper'

include OwnTestHelper

describe Beer do
  let!(:user) { FactoryGirl.create :user }
  let!(:style) {FactoryGirl.create(:style)}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can't be created if name not valid" do
    visit new_beer_path
    click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content "prohibited this beer from being saved"
  end

  it "can be created if info valid" do
    FactoryGirl.create(:brewery, name:"Testimesta", year:1666)
    visit new_beer_path
    fill_in('beer_name', with:"Testiolut")
    click_button "Create Beer"
    expect(Beer.count).to eq(1)
    expect(page).to have_content "Listing beers"
  end

end