module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  # different user?-functions
  def user?
    !current_user.nil?
  end

  def comment_owner? (comment_id)
    user? && (moderator? || Comment.find(comment_id).user_id == current_user.id)
  end

  def idea_owner? (idea_id)
    user? && (moderator? || Idea.find(idea_id).user_id == current_user.id)
  end

  def user_owner? (user_id)
    user? && (admin? || User.find(user_id) == current_user)
  end

  def moderator?
    user? && (admin? || current_user.moderator?)
  end

  def admin?
    user? && current_user.admin?
  end


  # Before filters
  def signed_in_user
    unless user?
      store_location
      flash[:warning] = 'Please sign in.'
      redirect_to signin_url
    end
  end

  def comment_owner
    unless comment_owner? (params[:id])
      flash[:warning] = 'Not your comment'
      redirect_to(ideas_path)
    end
  end

  def idea_owner
    unless idea_owner? (params[:id])
      flash[:warning] = 'Not your Idea'
      redirect_to(ideas_path)
    end
  end

  def user_owner
    unless user_owner?(params[:id])
      flash[:warning] = 'Not your User'
      redirect_to(root_url)
    end
  end

  def moderator_user
    if !moderator?
      flash[:warning] = 'Not moderator'
      redirect_to(root_url)
    end
  end

  def admin_user
    if !admin?
      flash[:warning] = 'Not admin'
      redirect_to(root_url)
    end
  end
end
