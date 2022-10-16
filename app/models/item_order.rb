class ItemOrder
  include ActiveModel::Model
  attr_accessor :token, :postal_cord, :city, :prefecture_id, :house_number, :building, :phone_number, :order_id, :item_id, :user_id

  with_options presence: true do
    validates :token, :city, :house_number, :building
    
    with_options numericality: { other_than: 1 } do
      validates :prefecture_id
    end
    validates :postal_cord, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :phone_number, format: { with: /\A\d{11}\z/ } 
  end

  def save
    Address.create(postal_cord: postal_cord, city: city, prefecture_id: prefecture_id, house_number: house_number, building: building, phone_number: phone_number, order_id: order_id)
    Order.create(user_id: user_id, item_id: item_id)
  end
end