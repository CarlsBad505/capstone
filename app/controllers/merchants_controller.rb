class MerchantsController < ApplicationController
require 'stripe'
Stripe.api_key = ENV['STRIPE_API_KEY']

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @account = Stripe::Account.retrieve(@merchant.stripe_id)
    @gift = Gift.new
  end
  
  def verification # What's the best way to do validation on these fields?
    @merchant = Merchant.find(params[:merchant_id]) # custom controller action requires explicit call out of :merchant_id as opposed to just :id
    account = Stripe::Account.retrieve(@merchant.stripe_id)
    account.legal_entity.dob.day = params[:day]
    account.legal_entity.dob.month = params[:month]
    account.legal_entity.dob.year = params[:year]
    account.legal_entity.first_name = params[:first_name]
    account.legal_entity.last_name = params[:last_name]
    account.legal_entity.type = params[:type]
    account.legal_entity.address.line1 = params[:line1]
    account.legal_entity.address.line2 = params[:line2]
    account.legal_entity.address.city = params[:city]
    account.legal_entity.address.state = params[:state]
    account.legal_entity.address.country = params[:country]
    account.legal_entity.address.postal_code = params[:postal_code]
    account.legal_entity.business_name = params[:business_name]
    account.legal_entity.ssn_last_4 = params[:last_four]
    # account.tax_id = params[:ein]
    account.tos_acceptance.date = Time.now.to_i
    account.tos_acceptance.ip = request.remote_ip
    account.save
    redirect_to root_path
  end
  
  def bank_account
    @merchant = Merchant.find(params[:merchant_id])
    account = Stripe::Account.retrieve(@merchant.stripe_id)
    if account.external_account = params[:token]
      account.save
      flash[:notice] = "Your bank account has been successfully saved!"
    else
      flash[:notice] = "Uh oh, something went wrong, please try again."
    end
  end
  
  def payment # Write conditional logic in here later for if user wants to save card
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def payment_stripe
    merchant = Merchant.find(params[:merchant_id])
    gift = current_user.customer.gifts.last
    amount = ((gift.gift_amount)*100)
    token = params[:token]
    begin
      charge = Stripe::Charge.create(
      :amount =>  amount, # amount has to be in cents
      :currency => "usd",
      :source => token,
      :description => "MyApp | #{merchant.store_name}", #Add name in here later
      :application_fee => (amount*0.1).to_i,
      :destination => merchant.stripe_id
      )
      gift.assign_attributes(charge: charge.id)
      gift.save!(validate: false)
    rescue Stripe::CardError => e
    end
    if charge != nil
      redirect_to merchant_confirmation_path
    else
      flash[:notice] = "Charge unsuccessful"
    end
  end
  
  def confirmation
    @merchant = Merchant.find(params[:merchant_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    def merchant_params
      params.require(:merchant).permit(:merchant_id)
    end
end
