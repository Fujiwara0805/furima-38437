class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :first_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :last_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name_k, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :last_name_k, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :date_of_birth, presence: true

  has_many :items
  has_many :orders
end
