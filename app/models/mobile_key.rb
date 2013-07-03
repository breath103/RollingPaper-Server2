class MobileKey < ActiveRecord::Base
  attr_accessible :device_type, :key
  # RELATIONS
  belongs_to :user
  # VALIDATIONS
  validates :device_type, presence: true, inclusion: { in: ["apn", "gcm"] }
  validates :key, presence: true, uniqueness: { case_sensitive: true }
end
