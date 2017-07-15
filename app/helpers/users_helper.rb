module UsersHelper

  def avatar_for(user)
    image_tag(user.avatar, alt: user.name, class: "avatar")
  end


end
