module ApplicationHelper

  def user_name(id)
    user = User.find_by(id: id)
    return user.name if user.present?
    return ""
  end
end
