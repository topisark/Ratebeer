require 'spec_helper'

include OwnTestHelper

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

  it "can delete his own ratings" do
    sign_in(username:"Pekka", password:"Foobar1")
    create_beer_with_rating(15, user)
    visit user_path(user)
    expect{
      click_link('Delete')
    }.to change{Rating.count}.by(-1)
  end
end

