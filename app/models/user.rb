class User < ApplicationRecord

  has_one :order, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :email, presence: true
  validates :password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
				 :omniauthable, omniauth_providers: [:facebook]

end
