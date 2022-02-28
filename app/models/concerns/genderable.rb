module Genderable
  extend ActiveSupport::Concern
  included do
    enum gender: ['male', 'female', 'non-binary']
  end
end