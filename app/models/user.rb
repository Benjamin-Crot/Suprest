class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :restaurants, dependent: :destroy
  has_many :suppliers, dependent: :destroy
  has_many :roles
  has_one :profile, dependent: :destroy
  has_many :accounts, through: :roles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

end
