class PlacesController < ApplicationController

  def index
    @places = @current_user.places
  end

  def show
    @place = @current_user.places.find_by(id: params["id"])
    
    if @place
      @entries = @place.entries
    else
      redirect_to places_path, alert: "Place not found."
    end
  end

  def new
  end

  def create
    @place = @current_user.places.build(name: params["name"])
    
    if @place.save
      redirect_to "/places", notice: 'Place was successfully created.'
    else
      render :new
    end
  end

end
