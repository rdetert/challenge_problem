module Localeable
  extend ActiveSupport::Concern
  included do
    enum locale: ['en_US', 'fr_CA']
  end
end