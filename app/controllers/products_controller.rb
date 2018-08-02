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


    resources = []
    @products.all.each do |product|
      resources << ProductResource.new(product, nil)
    end

    include_hash = {
        include: include_array
    }.compact

    serializer = JSONAPI::ResourceSerializer.new(ProductResource, include_hash)
    render json: serializer.serialize_to_hash(resources)
  end

  def show
    @product = Product.friendly.find(params[:id])

    #params[:include] = (params[:include])&.split(',') || ""
    include_hash = {
        include: params[:include]&.split(',')
    }.compact

    #byebug
    resource = ProductResource.new(@product, nil)
    serializer = JSONAPI::ResourceSerializer.new(ProductResource, include_hash)
    render json: serializer.serialize_to_hash(resource)
  end
end
