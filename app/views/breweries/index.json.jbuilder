json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year, :beers, :active
  json.beers do
      json.count brewery.beers.count
    end
    json
end


