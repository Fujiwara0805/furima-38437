require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  describe '購入者情報の保存' do
    before do
      @item_order = FactoryBot.build(:item_order)
    end

      it '全ての項目が入力されていれば購入ができる' do
        expect(@item_order).to be_valid
      end
      it 'token(クレジットカード情報)が空だと購入ができない' do
        @item_order.token = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと購入ができない' do
        @item_order.postal_cord = ""
        @item_order.valid?
        expect(@item_order.errors.messages).to include({:postal_cord => ["can't be blank", "is invalid"]} )
      end
      it '郵便番号にハイフンがないと登録できない' do
        @item_order.postal_cord = "1234567"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Postal cord is invalid")
      end
      it '郵便番号が8桁出ないと購入できない' do
        @item_order.postal_cord = "123-45678"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Postal cord is invalid")
      end
      it 'prefecture_idが空だと購入できない' do
        @item_order.prefecture_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと購入できない' do
        @item_order.city = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと購入できない' do
        @item_order.house_number = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと購入できない' do
        @item_order.phone_number = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが11桁でなければ購入できない' do
        @item_order.phone_number = "090123456789"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number is invalid")
      end
  end
end