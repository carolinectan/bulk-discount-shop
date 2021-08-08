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
  end
end
