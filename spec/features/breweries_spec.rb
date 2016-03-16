require 'spec_helper'

describe "Breweries page" do
  let!(:user) { FactoryGirl.create :user }

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "should not have any breweries before they have been created" do
    visit breweries_path
    expect(page).to have_content 'Number of breweries: 0'
  end

  describe "when breweries exists" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1, active: 1)
      end
      visit breweries_path
    end

    it "lists their total number", js: true do
      visit breweries_path
      expect(page).to have_content "Number of breweries: #{@breweries.count}"
    end

  end

  describe "when user is signed in" do
    before :each do
      sign_in(username:user.username, password:user.password)
    end

    it "can't create a brewery without name" do
      visit new_brewery_path
      click_button('Create Brewery')
      page.should have_content "can't be blank"
      Brewery.count.should be 0
    end

    it "can't create a brewery without year" do
      visit new_brewery_path
      fill_in('brewery_year', with: 1990)
      click_button('Create Brewery')
      Brewery.count.should be 0
    end

    it "can create a brewery with year and name" do
      visit new_brewery_path
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

end
