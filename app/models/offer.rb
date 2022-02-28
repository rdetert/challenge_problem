class Offer < ApplicationRecord

  has_many :offer_targets, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :header
  validates_presence_of :description
  validates_numericality_of :points, greater_than: 1
  validates_numericality_of :payout, greater_than: 1.0

  def to_s
    title
  end


  def self.total_payout_for_players_between_ages(min_age, max_age)
    # SELECT SUM(Q2.payout)
    # FROM (
    #         SELECT
    #           offers.id,
    #           P1.id,
    #           offers.payout
    #         FROM (SELECT id, DATE_PART('year', AGE('2022-02-28', birthdate)) AS years_old from players) P1
    #                   INNER JOIN
    #               offer_targets ON P1.years_old BETWEEN offer_targets.min_age AND offer_targets.max_age
    #                   INNER JOIN
    #               offers ON offers.id = offer_targets.offer_id
    #          GROUP by offers.id, P1.id
    #      ) Q2

    Offer
      .joins(:offer_targets)
      .joins("INNER JOIN (#{Player.ages.to_sql}) ages ON ages.years_old BETWEEN offer_targets.min_age AND offer_targets.max_age")
      .group("offers.id, ages.id")
      .where('offer_targets.min_age >= ? AND offer_targets.max_age <= ?', min_age, max_age)
      .sum(&:payout).to_f
  end

end
