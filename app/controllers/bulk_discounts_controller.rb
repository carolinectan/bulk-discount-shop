class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.bulk_discounts.create!(quantity: params[:quantity], percentage: (params[:percentage]))

    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy

    redirect_to merchant_bulk_discounts_path
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    bulk_discount =  BulkDiscount.find(params[:id])
    bulk_discount.update!(bulk_discount_params)

    redirect_to merchant_bulk_discount_path

    if bulk_discount.save
      flash[:notice] = "Bulk Discount ##{bulk_discount.id} was successfully updated!"
    # else
    #   flash[:alert] = "Bulk Discount ##{bulk_discount.id} was not successfully updated."
    end
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:quantity, :percentage)
  end
end
