FactoryBot.define do
  factory :item_order do
    token                    { 'tok_abcdefghijk00000000000000000' }
    postal_cord              { '123-4567' }
    prefecture_id            { 3 }
    city                     { '大分市' }
    house_number             { '1-1-1' }
    building                 { '建物ビル' }
    phone_number             { '09022223333' }
  end
end
