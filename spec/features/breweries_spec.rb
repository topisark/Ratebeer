require 'spec_helper'

describe "Breweries (integration tests)" do
  let!(:user) { FactoryGirl.create :user }

  describe "when user is signed in" do
    before :each do
      sign_in(username: user.username, password: user.password)
      visit new_brewery_path
    end

    it "can't create a brewery without name" do
      click_button('Create Brewery')
      page.should have_content "can't be blank"
      Brewery.count.should be 0
    end

    it "can't create a brewery without year" do
      fill_in('brewery_year', with: 1990)
      click_button('Create Brewery')
      Brewery.count.should be 0
    end

    it "can create a brewery with year and name" do
      fill_in('brewery_year', with: 1990)
      fill_in('brewery_name', with: "Kivapanimo")
      click_button('Create Brewery')
      Brewery.count.should be 1
      page.should have_content "Brewery was successfully created"
    end

  end

  describe "when user is not signed in" do

    it "can't create a new brewery" do
      visit breweries_path
      page.should_not have_content "New Brewery"
    end

    it "can't visit new brewery page" do
      visit new_brewery_path
      page.should have_content "You need to be signed in!"
    end

  end

  describe "when a brewery has been created" do
    let!(:brewery) { FactoryGirl.create :brewery }

    before :each do
      sign_in(username: user.username, password: user.password)
      visit brewery_path(brewery)
    end

    it "its page can be visited" do
      page.should have_content brewery.name
    end

    it "it can be modified" do
      click_link "Edit"
      fill_in('brewery_name', with: "ModifiedBrewery")
      click_button "Create Brewery"
      page.should have_content "Brewery was successfully updated"
    end

  end

end

describe "Breweries page" do
  let!(:user) { FactoryGirl.create :user }

  set_configurations_for_js_tests

  it "should not have any breweries before they have been created" do
    visit breweries_path
    expect(page).to have_content 'Number of breweries: 0'
  end

  describe "when breweries exists" do
    before :each do
      @breweries = create_multiple_breweries
      visit breweries_path
    end

    it "lists their total number" do
      expect(page).to have_content "Number of breweries: #{@breweries.count}"
    end

    it "shows the existing breweries", js: true do
      @breweries.each do |brewery_name|
        page.should have_content brewery_name
      end
    end

  end

end
