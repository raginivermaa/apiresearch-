class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :state, :description
  has_many :variants
  belongs_to :category
end
