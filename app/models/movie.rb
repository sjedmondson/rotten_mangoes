class Movie < ApplicationRecord

  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  scope :search_title_director, -> (search) { where('title LIKE ? OR director LIKE ?', "%#{search}%", "%#{search}%") }
  scope :movie_under_90, -> { where('runtime_in_minutes < 90') }
  scope :movie_90_to_120, -> { where('runtime_in_minutes >= 90 AND runtime_in_minutes <= 120') }
  scope :movie_over_120, -> { where('runtime_in_minutes > 120') }


  mount_uploader :image, ImageUploader

  def review_average
    if reviews.size >= 1
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
