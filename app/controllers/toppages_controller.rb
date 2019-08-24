class ToppagesController < ApplicationController
  def index
    @offer = Offer.limit(10).order(id: :desc)
  end
end
