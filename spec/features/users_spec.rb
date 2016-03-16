require 'spec_helper'
require 'own_test_helper'

describe "User" do

   let!(:user) { FactoryGirl.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to original page if wrong credentials given" do
      visit breweries_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'wrong')
      click_button('Sign in')

      expect(current_path).to eq(breweries_path)
      expect(page).to have_content 'Username and password do not match!'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "sees his own ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    create_beer_with_rating(15, user)
    visit user_path(user)
    expect(page).to have_content 'Has 1 rating'
  end

  it "his page displays the correct average rating" do
    sign_in(username:"Pekka", password:"Foobar1")
    create_beer_with_rating(10, user)
    create_beer_with_rating(30, user)
    visit user_path(user)
    expect(page).to have_content 'average 20'
  end


  it "can delete his own ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    create_beer_with_rating(15, user)
    visit user_path(user)
    expect{
      click_link('Delete')
    }.to change{Rating.count}.by(-1)
  end

end

describe "Users page" do

  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user2 }

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
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

  it "can dynamically search users",js:true do
    visit users_path
    fill_in("userSearch", with: "Topi")
    expect(page).to have_no_content "Pekka"
    expect(page).to have_content "Topi"
  end

end

