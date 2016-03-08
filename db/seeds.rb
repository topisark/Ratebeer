b1 = Brewery.create name:"Koff", year:1897, active:1
b2 = Brewery.create name:"Malmgard", year:2001, active:1
b3 = Brewery.create name:"Weihenstephaner", year:1042, active:1

s1 = Style.create name:"Lager", description:"Peruskamaa."

b1.beers.create name:"Iso 3", style:s1, brewery:b1

b1.beers.create name:"Karhu", style:"Lager"
b1.beers.create name:"Tuplahumala", style:"Lager"
b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
b2.beers.create name:"X Porter", style:"Porter"
b3.beers.create name:"Hefezeizen", style:"Weizen"
b3.beers.create name:"Helles", style:"Lager"