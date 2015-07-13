class RapidShareFile < ActiveRecord::Base
      has_one :user
      validates :file, presence: true
end
