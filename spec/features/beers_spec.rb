require 'spec_helper'

describe Beer do

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