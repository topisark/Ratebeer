FactoryGirl.define do

  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Topi"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :style do
    name "Teststyle"
  end

  factory :brewery do
    name "Testbrewery"
    year 1900
  end

  factory :beer do
    name "Testbeer"
    brewery
    style
  end
end