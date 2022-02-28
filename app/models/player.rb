class Player < ApplicationRecord
  include Genderable

  has_one :device, dependent: :destroy

  scope :without_device, ->{ left_outer_joins(:device).where(device: {id: nil}) }
  scope :ages, ->{ select(:id, "DATE_PART('year', AGE('#{Date.today.strftime("%Y-%m-%d")}', birthdate)) AS years_old") }

  def full_name
    "#{first_name} #{last_name}"
  end

  def pretty_birthdate
    birthdate.strftime("%Y-%m-%d") unless birthdate.blank?
  end

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :birthdate
  validates_presence_of :gender

  def self.ages_between(min_age, max_age)
    where('birthdate BETWEEN ? AND ?', max_age.years.ago, min_age.years.ago)
  end

  def self.total_payout(min_age, max_age)
    ages_between(min_age, max_age).merge(OfferTarget(a))
  end

  def years_old
    (Date.today - birthdate.to_date).to_i / 365
  end

end
