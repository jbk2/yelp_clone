class ReviewsController < ApplicationController
  
  # def new
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @review = Review.new
  # end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(params[:review].permit(:thoughts, :rating))

    if @review.save
      render 'create', content_type: :json #this is how we call the create.json.jbuilder

# poor way to customise the json data response from the database:
      # render json: @review.to_json(except: [:id, :created_at, :updated_at],
      #                            include: { restaurant: { except: 
      #                             [:id, :created_at, :updated_at] }})

# in order to cater for old old school browsers with js disabled, provide choice
# of a redirect if this, the review, responds to html not json:
      # respond_to do |format|
      #   format.html{ redirect_to '/restaurants' }
      #   format.json{ render json: review }
      # end
#  !!!! not you must specify 'json' format, as per line 30 in restaurant.js !!!
    else
      render '/restaurants'
    end 
  
  end
end
