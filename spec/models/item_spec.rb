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
    end
      context '商品出品がうまくいかないとき' do
        it '画像が空では登録されない' do
          @item.image = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
        end
        it '商品名が空では登録されない' do
          @item.name = ''
          @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
        end
        it 'テキストが空では登録されない' do
          @item.text = ''
          @item.valid?
        expect(@item.errors.full_messages).to include("テキストを入力してください")
        end
        it 'カテゴリーが空では登録されない' do
          @item.category_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
        end
        it '商品の状態が空では登録されない' do
          @item.condition_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください", "商品の状態は数値で入力してください")
        end
        it '配送料金が空では登録されない' do
          @item.delivery_fee_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("配送料金を入力してください", "配送料金は数値で入力してください")
        end
        it '発送元の地域が空では登録されない' do
          @item.prefecture_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください", "発送元の地域は数値で入力してください")
        end
        it '発送までの日数が空では登録されない' do
          @item.delivery_day_id = nil
          @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください", "発送までの日数は数値で入力してください")
        end
        it 'カテゴリーに1が選択された場合は登録されない' do
          @item.category_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
        end
        it '商品の状態に1が選択された場合は登録されない' do
          @item.condition_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
        end
        it '配送料金に1が選択された場合は登録されない' do
          @item.delivery_fee_id = '1' 
          @item.valid?
          expect(@item.errors.full_messages).to include("配送料金は1以外の値にしてください")
        end
        it '発送元の地域に1が選択された場合は登録されない' do
          @item.prefecture_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
        end
        it '発送までの日数に1が選択された場合は登録されない' do
          @item.delivery_day_id = '1'
          @item.valid?
          expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
        end
        it '価格が空では登録されない' do
          @item.price = ""
          @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は数値で入力してください")
        end
        it '価格が半角数字以外では登録できない' do
          @item.price = "１０００"
          @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
        end
        it '価格が300より少ないと登録できない' do
          @item.price = "50"
          @item.valid?
          expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
        end
        it '価格が9999999より大きいと登録できない' do
          @item.price = "10000000"
          @item.valid?
          expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
        end
        it 'ユーザーが紐付いていない場合は登録できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Userを入力してください")
        end
      end
  end
end  