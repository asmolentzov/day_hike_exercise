class User < ApplicationRecord  
  validates_presence_of :name, :role
  
  enum role: [:default, :admin]
  
  has_secure_password
  
end