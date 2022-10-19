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
      it '建物は空でも購入できる' do
        @item_order.building = ''
        expect(@item_order).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'クレジットカード情報が空だと購入ができない' do
        @item_order.token = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("クレジット情報を入力してください")
      end
      it '郵便番号が空だと購入ができない' do
        @item_order.postal_cord = ""
        @item_order.valid?
        expect(@item_order.errors.messages).to include({:postal_cord => ["を入力してください", "は不正な値です"]} )
      end
      it '郵便番号にハイフンがないと登録できない' do
        @item_order.postal_cord = "1234567"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '郵便番号が8桁出ないと購入できない' do
        @item_order.postal_cord = "123-45678"
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it '都道府県が空だと購入できない' do
        @item_order.prefecture_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("都道府県を入力してください", "都道府県は数値で入力してください")
      end
      it '都道府県に1が選択された場合は登録されない' do
        @item_order.prefecture_id = '1'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("都道府県は1以外の値にしてください")
      end
      it '市区町村が空だと購入できない' do
        @item_order.city = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空だと購入できない' do
        @item_order.house_number = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空だと購入できない' do
        @item_order.phone_number = ""
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end
      it '電話番号が9桁以下だと購入できない' do
        @item_order.phone_number = '090123456'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号が12桁以上だと購入できない' do
        @item_order.phone_number = '090123456789'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("電話番号は不正な値です")
      end
      it '電話番号に半角数字以外が含まれていると購入できない' do
        @item_order.phone_number = '０9012345678'
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'ユーザーが紐付いていないと購入できない' do
        @item_order.user_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Userを入力してください")
      end
      it '商品が紐付いていないと購入できない' do
        @item_order.item_id = nil
        @item_order.valid?
        expect(@item_order.errors.full_messages).to include("Itemを入力してください")
      end
    end  
  end
end