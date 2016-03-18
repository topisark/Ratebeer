require 'spec_helper'

describe "Beers (integration tests)" do
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
    fill_in('beer_name', with: "TestBeer")
    click_button "Create Beer"
    expect(Beer.count).to eq(1)
  end

  describe "when a beer has been added" do
    let!(:beer) { FactoryGirl.create :beer }

    it "its page can be visited" do
      visit beer_path(beer)
      page.should have_content beer.name
      page.should have_content beer.brewery.name
    end

    it "it can be modified" do
      visit beer_path(beer)
      click_link "Edit"
      fill_in('beer_name', with: beer.name.reverse)
      click_button "Create Beer"
      page.should have_content "Beer was successfully updated"
    end

  end

end

describe "Beers page" do

  set_configurations_for_js_tests

  let!(:beer) { FactoryGirl.create :beer }

  it "lists beers", js: true do
    visit beers_path
    page.should have_content beer.name
  end

  it "can dynamically search beers", js: true do
    visit beers_path
    fill_in("beerSearch", with: "WrongName")
    page.should have_no_content beer.name
    fill_in("beerSearch", with: beer.name)
    page.should have_content beer.name
  end

end