class ApplicationsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    offer = Offer.find(params[:offer_id])
    current_user.apply(offer)
    flash[:success] = 'オファーに応募しました。'
    redirect_to offer
  end
end
