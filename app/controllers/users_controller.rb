class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
    @offers = @user.offers.order(id: :desc).page(params[:page])
    @app_offers = @user.app_offers.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールを変更しました。'
      redirect_to @user
    else
      flash[:danger] = 'プロフィールの変更に失敗しました。'
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :level, :memo, :image)
  end
  
  def correct_user
    user = User.find(params[:id])
    
    unless current_user == user
      redirect_back(fallback_location: root_path)
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
