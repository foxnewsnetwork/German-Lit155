module SessionsHelper
  
  def current_user?(user_id)
    current_user.id == user_id
  end
  
  def current_user_admin?
    User.find_by_id(current_user.id).admin
  end

  def deny_access
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

end
