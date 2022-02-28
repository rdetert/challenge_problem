module Osable
  extend ActiveSupport::Concern
  included do
    enum os: ['ios', 'android']
  end
end