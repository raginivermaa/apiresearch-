class ProductResource < JSONAPI::Resource
  attributes :name, :state, :description
  has_many :variants
  has_one :category
end
