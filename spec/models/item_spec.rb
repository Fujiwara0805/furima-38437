require 'rails_helper'
describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it '全ての項目が入力されていれば出品ができる' do
        expect(@item).to be_valid
      end

      context '商品出品がうまくいかないとき' do
        it 'imageが空では登録されない' do
          @item.image = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it 'nameが空では登録されない' do
          @item.name = ''
          @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
        end
        it 'textが空では登録されない' do
          @item.text = ''
          @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
        end
        it 'category_idが空では登録されない' do
          @item.category_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
        end
        it 'condition_idが空では登録されない' do
          @item.condition_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", "Condition is not a number")
        end
        it 'delivery_fee_idが空では登録されない' do
          @item.delivery_fee_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank", "Delivery fee is not a number")
        end
        it 'prefecture_idが空では登録されない' do
          @item.prefecture_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
        end
        it 'delivery_day_idが空では登録されない' do
          @item.delivery_day_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank", "Delivery day is not a number")
        end
        it 'それぞれのidで1が選択された場合は登録されない' do
          @item.category_id = '1'
          @item.condition_id = '1'
          @item.delivery_fee_id = '1' 
          @item.prefecture_id = '1'
          @item.delivery_day_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("Category must be other than 1", "Condition must be other than 1", "Delivery fee must be other than 1", "Prefecture must be other than 1", "Delivery day must be other than 1")
        end
        it 'priceが空では登録されない' do
          @item.price = ""
          @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is invalid", "Price is not a number")
        end
        it 'priceが半角数字以外では登録できない' do
          @item.price = "１０００"
          @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
        end
        it 'priceが300より少ないと登録できない' do
          @item.price = "50"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than 300")
        end
        it 'priceが9999999より少ないと登録できない' do
          @item.price = "10000000"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than 9999999")
        end
      end
    end
  end
end  