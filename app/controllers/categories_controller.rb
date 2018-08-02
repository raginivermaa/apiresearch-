class CategoriesController < ApplicationController
  def index
    @categories = Category.order('label')

    include_hash = {
        include: params[:include]&.split(',')
    }.compact
    render json: CategorySerializer.new(@categories, include_hash).serialized_json
  end

  def show
    @category = Category.friendly.find(params[:id])

    include_hash = {
        include: params[:include]&.split(',')
    }.compact
    render json: CategorySerializer.new(@category, include_hash).serialized_json
  end
end
