class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day
  # has_one :order

  with_options presence: true do
    validates :name, :text, :image
    
    with_options numericality: { other_than: 1 } do
      validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_day_id
    end
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 } 
  end
end
