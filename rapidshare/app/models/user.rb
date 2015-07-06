class User < ActiveRecord::Base
      validates :username, presence: true, length: {minimum: 4}
      validates :password, presence: true
      validates_confirmation_of :password, message: "Both the pass should match"
      validates :salt, presence: true
end
