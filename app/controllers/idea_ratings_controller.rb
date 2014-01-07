class IdeaRatingsController < ApplicationController

  def create

    rating = IdeaRating.new
    rating.idea_id = params[:idea_rating][:idea_id]
    rating.rating = params[:idea_rating][:rating]
    rating.user = current_user

    if rating.save
      flash.now[:success] = 'Rating saved!'
    elsif
      flash.now[:error] = 'Rating not saved!'
    end

  end


  def update

    rating = IdeaRating.find(params[:id])
    rating.rating = params[:idea_rating][:rating]

    if rating.save
      flash.now[:success] = 'Rating updated!'
    elsif
      flash.now[:error] = 'Rating not updated!'
    end
  end
end
