class User < ActiveRecord::Base
  attr_accessible :password, :subscription_id

  has_secure_password
  validates_presence_of :password, :on => :create

  has_many :experiments
end
