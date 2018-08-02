class ProductsController < ApplicationController
  def index

    if params[:page]
      if params[:page] == ""
        page = 1
      else
        page = params[:page]
      end
    else
      page = 1
    end

    if params[:size]
      if params[:size] == ""
        size = 3
      else
        size = params[:size]
      end
    else
      size = 3
    end


    if params[:sort_by]
      if params[:sort_by] == ""
        sort_by = 'name'
      else
        sort_by = params[:sort_by]
      end
    else
      sort_by = 'name'
    end

    @product_search = ProductSearch.new
    include_array = params[:include]&.split(',')

    @product_search.search(params).sort_by(sort_by)
    @products = @product_search.products.eager_load(include_array).paginate(page: page, per_page: size)
    # @categories = Category.all


    include_hash = {
        include: include_array
    }.compact

    render json: ProductSerializer.new(@products, include_hash).serialized_json
  end

  def show
    @product = Product.friendly.find(params[:id])

    include_hash = {
        include: params[:include]&.split(',')
    }.compact

    render json: ProductSerializer.new(@product, include_hash).serialized_json
  end
end
