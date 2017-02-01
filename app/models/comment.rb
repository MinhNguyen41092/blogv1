class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article 
  validates_uniqueness_of :user, scope: :article
  validates :user_id, presence: true
  validates :article_id, presence: true
  validates :comment, presence: true, length: { minimum: 5, maximum: 100 }
end