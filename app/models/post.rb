class Post < ApplicationRecord
  belongs_to :user


  attribute :tags, :string, array: true, default: []
  attribute :comments, :string, array: true, default: []


  validates :title, :body, presence: true
  validates :tags, presence: true
  validate :must_have_at_least_one_tag

  def must_have_at_least_one_tag
    errors.add(:tags, "must include at least one tag") if tags.empty?
  end
has_many :comments

end
