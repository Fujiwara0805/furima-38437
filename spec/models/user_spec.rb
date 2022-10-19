require 'rails_helper'

describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "全ての項目が正しく入力されてあれば登録できる" do
        expect(@user).to be_valid
      end
    end
  end
  
  context '新規登録がうまくいかないとき' do
    it "ニックネームが空だと登録できない" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it "Eメールに@を含まない場合は登録できない" do
      @user.email ='hogehuga.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールは不正な値です")
    end
    it "Eメールが空では登録できない" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end
    it "重複したEメールが存在する場合登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid? 
      expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
    end
    it "パスワードが空では登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードには半角の英字数字の両方を含めて設定してください", "パスワード（確認用）とパスワードの入力が一致しません")
    end
    it "パスワードが5文字以下であれば登録できない" do
      @user.password = "00000"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは6文字以上で入力してください", "パスワードには半角の英字数字の両方を含めて設定してください")
    end
    it "パスワードが存在してもパスワード（確認用）が空では登録できない" do
      @user.password = "000000"
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードには半角の英字数字の両方を含めて設定してください")
    end
    it "数字のみのパスワードでは登録できない" do
      @user.password = "111111"
      @user.password_confirmation = "111111"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードには半角の英字数字の両方を含めて設定してください")
    end
    it "英字のみのパスワードでは登録できない" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードには半角の英字数字の両方を含めて設定してください")
    end
    it "全角文字を含むパスワードでは登録できない" do
      @user.password = "aaa１１１１"
      @user.password_confirmation = "aaa１１１１"
      @user.valid?    
      expect(@user.errors.full_messages).to include("パスワードには半角の英字数字の両方を含めて設定してください")
    end
    it "苗字が空では登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は不正な値です")
    end
    it "名前が空では登録できない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください", "名前は不正な値です")
    end
    it "苗字が半角文字だと登録できない" do
      @user.first_name = "tarou"
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字は不正な値です")
    end
    it "名前が半角文字だと登録できない" do
      @user.last_name = "yamada"
      @user.valid?
      expect(@user.errors.full_messages).to include("名前は不正な値です")
    end
      it "苗字（カナ）が空だと登録できない" do
      @user.first_name_k = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください", "苗字（カナ）は不正な値です")
      end
    it "名前（カナ）が空だと登録できない" do
      @user.last_name_k = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("名前（カナ）を入力してください", "名前（カナ）は不正な値です")
    end
    it "苗字（カナ）がカタカナでないと登録できない" do
      @user.first_name_k = "tarou"      
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字（カナ）は不正な値です")
    end
    it "名前（カナ）がカタカナでないと登録できない" do
      @user.last_name_k = "yamada"      
      @user.valid?
      expect(@user.errors.full_messages).to include("名前（カナ）は不正な値です")
    end
    it "誕生日が空では登録できない" do
    @user.date_of_birth = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("誕生日を入力してください")
    end
  end
end