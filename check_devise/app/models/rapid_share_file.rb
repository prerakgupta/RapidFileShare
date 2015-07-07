require 'carrierwave/orm/activerecord'

class RapidShareFile < ActiveRecord::Base
      mount_uploader :file, FileUploader
      validates :file, presence: true
end
