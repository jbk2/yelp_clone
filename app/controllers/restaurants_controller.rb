class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    raise 'hello'
    Restaurant.create(params[:restaurant].permit(:name, :address))
    redirect_to '/restaurants'
  end 

end
