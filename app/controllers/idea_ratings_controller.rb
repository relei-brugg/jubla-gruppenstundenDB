class IdeaRatingsController < ApplicationController

  before_action :not_idea_owner, only: [:create, :update]

  def create
    # workaround for multiple votes, if first vote
    rating = IdeaRating.find_by_idea_id_and_user_id(params[:idea_rating][:idea_id], current_user.id)
    rating = IdeaRating.new(idea_id: params[:idea_rating][:idea_id], user: current_user) unless rating

    rating.rating = params[:idea_rating][:rating]
    if rating.save
      respond_to do |format|
        format.json {
          render status: '200', json:  {
              avg: rating.idea.idea_ratings.average(:rating)
          }
        }
      end
    end
  end


  def update

    rating = IdeaRating.find(params[:id])

    rating.rating = params[:idea_rating][:rating]
    if rating.save
      respond_to do |format|
        format.json {
          render status: '200', json:  {
              avg: rating.idea.idea_ratings.average(:rating)
          }
        }
      end
    end
  end
end
