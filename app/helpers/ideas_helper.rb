module IdeasHelper
  def handleStep
    @idea.current_step = session[:idea_step]

    if params[:back_button]
      @idea.previous_step
    else
      @idea.next_step if @idea.valid?
    end

    session[:idea_step] = @idea.current_step
  end

  def resetSession
    session[:idea_step] = 0
    session[:idea_params] = {}
  end


  def filterIdeas
    @search = Idea.new

    if (params[:idea])
      @search = Idea.new(idea_params)

      if @search.season_categories.size > 0
        # get all ideas with selected seasons
      end

      if @search.title
        @ideas = @ideas.where("LOWER(title) LIKE ?", '%'+@search.title.downcase+'%')
      end

      @ideas = @ideas.where('age_min <= ? AND age_max >= ?', @search.age_max, @search.age_min)
      @ideas = @ideas.where('group_size_min <= ? AND group_size_max >= ?', @search.group_size_max, @search.group_size_min)
    end
  end
end
