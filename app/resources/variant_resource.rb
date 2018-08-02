class VariantResource < JSONAPI::Resource
  attributes :name, :sold_out, :under_sale, :price, :sale_price
  belongs_to :product
end