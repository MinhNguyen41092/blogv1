class Article < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true
  
  def self.search(search)
    where("name || body LIKE ?", "%#{search}%")
  end
end