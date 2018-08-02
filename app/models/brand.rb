class Brand < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged, slug_column: :slug_url

  has_many :products, class_name: "Product"

  validates :name, presence: true
  validates :state, presence: true
  validates :description, presence: true
  validates :state, inclusion: { in: %w(draft published discontinued) }


end
