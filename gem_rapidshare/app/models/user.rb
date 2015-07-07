require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base
      mount_uploader :file, FileUploader
      validates :file, presence: true
end
