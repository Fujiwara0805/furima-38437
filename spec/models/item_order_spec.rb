require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  describe '購入者情報の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @item_order = FactoryBot.build(:item_order, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it '全ての項目が入力されていれば購入ができる' do
        expect(@item_order).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @item_order.building = ''
        expect(@item_order).to be_valid
      end
    end

    context '内容に問題がある場合' do
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
      it 'prefecture_idに1が選択された場合は登録されない' do
        @item_order.prefecture_id = '1'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Prefecture must be other than 1")
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
      it 'phone_numberが9桁以下だと購入できない' do
        @item_order.phone_number = '090123456'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @item_order.phone_number = '090123456789'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberに半角数字以外が含まれていると購入できない' do
        @item_order.phone_number = '０9012345678'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Phone number is invalid")
      end
      it 'userが紐付いていないと購入できない' do
        @item_order.user_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと購入できない' do
        @item_order.item_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Item can't be blank")
      end
    end  
  end
end