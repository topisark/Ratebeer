json.array!(@beers) do |beer|
  json.extract! beer, :id, :name
  json.style do
    json.name beer.style.name
    json.id beer.style.id
  end
  json.brewery do
    json.name beer.brewery.name
    json.id beer.brewery.id
  end
end