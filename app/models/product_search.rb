class ProductSearch

  attr_reader :products

  def initialize
    # @products = Product.scope
  end

  def search(params)

    @products = Product.where(["name LIKE ?", "%#{params[:keywords]}%"]) if params.dig(:keywords).present?
    @products = @products.where(["category_id = ?", params[:parent]]) if params.dig(:parent).present?
    @products = Product.all unless @products

    self

  end

  def sort_by(sort_by)
    @products = @products.order(sort_by) if sort_by.present?
    self
  end


end
