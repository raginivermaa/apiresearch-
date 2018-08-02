class Product < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged, slug_column: :slug_url

  belongs_to :category, class_name: "Category", foreign_key: "category_id"
  has_many :variants, class_name: "Variant"
  belongs_to :brands, class_name: "Brand", foreign_key: "brand_id"

  validates :name, presence: true
  validates :state, presence: true
  validates :description, presence: true
  validates :state, inclusion: { in: %w(draft published discontinued) }


end
