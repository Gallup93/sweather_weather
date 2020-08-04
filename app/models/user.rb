require 'securerandom'

class User < ApplicationRecord
  before_create :get_api_key
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :password_confirmation, require: true

  has_secure_password

  private

  def get_api_key
    self.api_key = SecureRandom.hex(27)
  end
end
