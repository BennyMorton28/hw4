class EntriesController < ApplicationController

  def new
  end

  def create
    # First, find the place within the current_user's scope to ensure security
    place = @current_user.places.find_by(id: params["place_id"])
    
    # Proceed only if the place exists
    if place
      @entry = place.entries.build(
        title: params["title"],
        description: params["description"],
        occurred_on: params["occurred_on"]
      )
      @entry.uploaded_image.attach(params[:uploaded_image]) if params[:uploaded_image].present?

      if @entry.save
        redirect_to "/places/#{place.id}", notice: 'Entry was successfully created.'
      else
        # Handle save failure, for now, redirect back to the place
        redirect_to "/places/#{place.id}", alert: 'Failed to create entry.'
      end
    else
      # If the place doesn't exist in the current_user's scope, redirect to all places
      redirect_to "/places", alert: 'Place not found.'
    end
  end

end
