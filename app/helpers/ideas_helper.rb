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
    session[:idea_step] = nil
    session[:idea_params] = nil
  end
end
