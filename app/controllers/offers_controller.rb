class OffersController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  before_action :set_offer, only: [:show, :destroy]
  
  def index
    @offer = Offer.order(id: :desc).page(params[:page])
  end

  def show
    @offer = Offer.find(params[:id])
    @app_users = @offer.app_users.order(id: :desc).page(params[:page])
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
  
  def destroy
    @offer.destroy
    flash[:success] = 'オファーを削除しました。'
    redirect_to user_path(current_user)
  end

  private

  def offer_params
    params.require(:offer).permit(:game_date, :area, :ground, :memo)
  end
  
  def correct_user
    @offer = Offer.find(params[:id])
    unless current_user == @offer.user
      redirect_back(fallback_location: root_path)
    end
  end
  
  def set_offer
    @offer = Offer.find(params[:id])
  end
end