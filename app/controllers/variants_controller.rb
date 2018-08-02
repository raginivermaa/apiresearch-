class VariantsController < ApplicationController
  def index
    @variants = Variant.all

    include_hash = {
        include: params[:include]&.split(',')
    }.compact

    render json: VariantSerializer.new(@variants, include_hash).serialized_json
  end

  def show
    @variant = Variant.find(params[:id])
    @product = @variant.product

    include_hash = {
        include: params[:include]&.split(',')
    }.compact
    render json: VariantSerializer.new(@variant, include_hash).serialized_json
  end

  def new
    @variant = Variant.new
  end

  def edit
    @variant = Variant.find(params[:id])
  end

  def create
    @variant = Variant.new(variant_params)
    @product = @variant.product
    if @variant.save
      flash[:success] = "Successfully edited & updated variant"
      redirect_to @variant

    else
      puts @variant.errors.full_messages
      render 'new'

    end

  end

  def update
    @variant = Variant.find(params[:id])
    if @variant.update_attributes(variant_params)
      "Successful update"
    else
      render 'edit'
    end
  end


  def destroy
    @variant = Variant.find(params[:id])
    @variant.destroy

    redirect_to variants_path
  end


  private

  def variant_params
    params.require(:variant).permit(:name, :sold_out, :under_sale, :price, :sale_price, :sale_text, :product_id)
  end

end
