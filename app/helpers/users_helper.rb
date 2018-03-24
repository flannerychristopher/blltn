module UsersHelper

  def avatar_for(user)
    image_tag(user.avatar, alt: user.name, class: "avatar")
  end

  def select_admins(users)
    users.joins(:memberships).where(memberships: { admin: true, board_id: @board.id } )
  end

end
