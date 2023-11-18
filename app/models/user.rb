class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :regular_links, dependent: :destroy
  has_many :temporal_links, dependent: :destroy
  has_many :private_links, dependent: :destroy
  has_many :ephemeral_links, dependent: :destroy
end
