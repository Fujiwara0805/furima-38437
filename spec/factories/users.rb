FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.free_email}
    password               {'test1234test'}
    password_confirmation  { password }
    first_name            {'ひらがな'}
    last_name             {'漢字'}
    first_name_k          {'カタカナ'}
    last_name_k           {'カタカナ'}
    date_of_birth         {Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today)}
  end
end