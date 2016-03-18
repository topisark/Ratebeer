require 'spec_helper'

describe Beer do
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username: user.username, password: user.password)
  end

  it "can't be created if name not valid" do
    visit new_beer_path
    click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content "can't be blank"
  end

  it "can be created if info valid" do
    FactoryGirl.create(:style)
    FactoryGirl.create(:brewery)
    visit new_beer_path
    fill_in('beer_name', with: "Testiolut")
    click_button "Create Beer"
    expect(Beer.count).to eq(1)
    expect(page).to have_content "Listing beers"
  end

end

describe "Beers page" do

  set_configurations_for_js_tests

  let!(:beer) { FactoryGirl.create :beer}

  it "lists beers",js:true do
    visit beers_path
    page.should have_content beer.name
  end

end