class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :first_name, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}
  validates :last_name, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}
  validates :first_name_k, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :last_name_k, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :date_of_birth, presence: true


  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  
  with_options presence: true, format: { with: VALID_PASSWORD_REGEX, message:'には英字と数字の両方を含めて設定してください' }, confirmation: true do
    validates :password
  end
    
  has_many :items
  has_many :orders
end
