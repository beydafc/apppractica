class RestaurantsController < ApplicationController

  # GET/restaurants
  def index
    if params[:query].present?
      @restaurants = Restaurant.global_search(params[:query])
    else
      @restaurants = Restaurant.all
    end

    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
      }
    end
  end

  # GET/restautrants/:id
  def show
    @restaurant = Restaurant.find(params[:id])

    @markers = [
      {
        lat: @restaurant.latitude,
        lng: @restaurant.longitude
      }
    ]
  end

  # GET/restautrants/new
  def new
    @restaurant = Restaurant.new
    @categories = Category.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save
      redirect_to restaurants_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # /restautrants/:id/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
    @categories = Category.all
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  def my_restaurants
    @restaurants = Restaurant.where(user_id: current_user.id)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :address, :photo, category_ids: [])
  end
end
