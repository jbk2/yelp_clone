 class RestaurantsController < ApplicationController

before_action :authenticate_user!, except: [:index] #this is a rails helper to 
# ensure that you don't have to write authenticate_user! on every action.

  def index
    @restaurants = Restaurant.all
    @review = Review.new
  end


  def new
    authenticate_user! #devise helper method will redirect to sign up page if
    @restaurant = Restaurant.new # user not authenticated/signed in. 
  end


  def create
    @restaurant = Restaurant.new(params[:restaurant].permit(:name, :address, :cuisine))
    @restaurant.user = current_user #Setting the user attribute of restaurant.

    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end 
  end 


  def edit
    @restaurant = current_user.restaurants.find params[:id]
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Not your restaurant!"
    redirect_to '/restaurants'
  end


  def update
    @restaurant = current_user.restaurants.find(params[:id])

    if @restaurant.update(params[:restaurant].permit(:name, :address, :cuisine))
      redirect_to '/restaurants'
    else
      render 'edit'
    end
  end 


  def destroy
    @restaurant = current_user.restaurants.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Deleted successfully'
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Not your restaurant!"
  ensure
    redirect_to '/restaurants'
  end

end