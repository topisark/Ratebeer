require 'spec_helper'

describe "Places" do

  city = "Helsinki"
  bar1 = "Oljenkorsi"
  bar2 = "Mbar"

  it "if one is returned by the API, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with(city).and_return(
        [ Place.new(:id => 1, :name => bar1) ]
    )

    visit places_path
    fill_in('city', with: city)
    click_button "Search"

    expect(page).to have_content bar1
  end

  it "if multiple are returned by the API, they are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with(city).and_return(
        [ Place.new(:id => 1, :name => bar1), Place.new(:id => 2, :name => bar2) ]
    )

    visit places_path
    fill_in('city', with: city)
    click_button "Search"

    expect(page).to have_content bar1
    expect(page).to have_content bar2
  end

  it "if none are returned by the API, it displays correctly" do
    allow(BeermappingApi).to receive(:places_in).with(city).and_return([ ])

    visit places_path
    fill_in('city', with: city)
    click_button "Search"

    expect(page).to have_content "No locations in"
  end
end