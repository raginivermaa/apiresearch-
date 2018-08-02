class CategoryResource < JSONAPI::Resource
  attributes :label, :state, :parent_id
  has_many :subcategories
  has_many :products
end