class OffersController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  
  def index
    @offer = Offer.order(id: :desc).page(params[:page])
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = current_user.offers.build(offer_params)
    if @offer.save
      flash[:success] = 'オファーを投稿しました。'
      redirect_to @offer
    else
      flash.now[:danger] = 'オファーの投稿に失敗しました。'
      render :new
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:game_date, :area, :ground, :memo)
  end
end