class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body

  has_many_attached :videos
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :title, presence: true, length: { maximum: 120 }

  after_create_commit do
  end

  after_update_commit do
  end

  after_destroy_commit do
  end

end
