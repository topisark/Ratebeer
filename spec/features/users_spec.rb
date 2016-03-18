require 'spec_helper'

describe "Users (integration tests)" do

   let!(:user) { FactoryGirl.create :user }

   it "when signed up with good credentials, is added to the system" do
     visit signup_path
     fill_in('user_username', with:'Topi')
     fill_in('user_password', with:'Secret55')
     fill_in('user_password_confirmation', with:'Secret55')

     expect{
       click_button('Create User')
     }.to change{User.count}.by(1)
   end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:user.username, password:user.password)

      page.should have_content 'Welcome back!'
      page.should have_content user.username
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

   describe "who has signed in" do
     before :each do
       sign_in(username:user.username, password:user.password)
       create_beer_with_rating(10, user)
       create_beer_with_rating(30, user)
       visit user_path(user)
     end

     it "sees his own ratings" do
       page.should have_content "Has #{user.ratings.count} rating"
       page.should have_content user.ratings.first.beer.name
     end

     it "his page displays the correct average rating" do
       page.should have_content 'average 20'
     end

     it "can delete his own ratings" do
       expect{
         first(:link, "Delete").click
       }.to change{Rating.count}.by(-1)
     end

     it "can change his password" do
       click_link "Edit profile"
       fill_in('user_password', with:'Newpass88')
       fill_in('user_password_confirmation', with:'Newpass88')
       click_button "Update User"
       page.should have_content "User was successfully updated"
     end

    it "can log out" do
      click_link user.username #This opens the user dropdown menu
      click_link "Log out"
      page.should have_button "Sign in"
    end

   end

end

describe "Users page" do

  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user2 }

  set_configurations_for_js_tests

  it "lists existing users",js:true do
    visit users_path
    page.should have_content user.username
    page.should have_content user2.username
  end

  it "can dynamically search users",js:true do
    visit users_path
    page.should have_content user.username
    page.should have_content user2.username
    fill_in("userSearch", with: user.username)
    page.should have_no_content user2.username
    page.should have_content user.username
  end

end

