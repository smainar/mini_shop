class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to "/merchants"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    redirect_to "/merchants/#{@merchant.id}"
  end

  def destroy
    merchant = Merchant.destroy(params[:id])
    flash[:success] = "#{merchant.name} has been deleted."
    redirect_to "/merchants"
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
