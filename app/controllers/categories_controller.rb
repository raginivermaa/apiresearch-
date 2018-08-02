class CategoriesController < ApplicationController
  def index
    @categories = Category.order('label')

    resources = []
    @categories.all.each do |category|
      resources << CategoryResource.new(category, nil)
    end

    include_hash = {
        include: params[:include]&.split(',')
    }.compact

    serializer = JSONAPI::ResourceSerializer.new(CategoryResource, include_hash)
    render json: serializer.serialize_to_hash(resources)

  end

  def show
    @category = Category.friendly.find(params[:id])
    resource = CategoryResource.new(@category, nil)

    include_hash = {
        include: params[:include]&.split(',')
    }.compact

    serializer = JSONAPI::ResourceSerializer.new(CategoryResource, include_hash)
    render json: serializer.serialize_to_hash(resource)
  end
end
