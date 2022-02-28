class Device < ApplicationRecord
  include Osable
  include Localeable

  belongs_to :player

  validates_presence_of :device_model
  validates_presence_of :os
  validates_presence_of :os_version
  validates_presence_of :locale

  scope :os_versions_gte, ->(version) { where('os_version >= ?', version) }
  scope :os_versions_lte, ->(version) { where('os_version <= ?', version) }

end
