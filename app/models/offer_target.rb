class OfferTarget < ApplicationRecord
  include Genderable
  include Osable
  include Localeable

  belongs_to :offer

  validates_presence_of :min_age
  validates_presence_of :max_age
  validates_presence_of :gender
  validates_presence_of :os
  validates_presence_of :min_os_version
  validates_presence_of :locale

  validates_numericality_of :min_age, greater_than: 10
  validates_numericality_of :max_age

  validate :min_age_lt_max_age

  scope :age_gte, ->(age) { where('min_age >= ?', age) }
  scope :age_lte, ->(age) { where('max_age <= ?', age) }
  scope :ages_between, ->(min_age, max_age) { age_gte(min_age).age_lte(max_age) }
  scope :os_versions_gte, ->(min_ver) { where('min_os_version >= ?', min_ver) }



  private

    def min_age_lt_max_age
      if min_age.to_i >= max_age.to_i
        errors.add :base, :invalid, message: "Minimum age needs to be larger than the maximum age"
      end
    end

end
