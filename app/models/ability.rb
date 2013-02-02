class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      logged_in = true
    end
    user ||= User.new # guest user (not logged in)
    can :read, Page
    can :read, Post
    can :read, Album
    can :read, Photo
    can :create, User
    if user.admin
      can :manage, :all
    end
    if logged_in
      can :read, Forum
      can :read, Comment
      can :create, Comment
      can :read, Event
      can :read, Todo
      can :write, Todo
      page_access = false
      post_access = false
      photo_access = false
      event_access = false
      user_access = false
      forum_access = false
      group_access = false
      user.groups.each do |g|
        page_access ||= g.page_access
        post_access ||= g.post_access
        photo_access ||= g.photo_access
        event_access ||= g.event_access
        user_access ||= g.user_access
        forum_access ||= g.forum_access
        group_access ||= g.group_access
      end
      if page_access
        can :manage, Page
      end
      if post_access
        can :manage, Post
      end
      if photo_access
        can :manage, Photo
        can :manage, Album
      end
      if user_access
        can :manage, User
      end
      if forum_access
        can :manage, Forum
        can :manage, Comment
      end
      if group_access
        can :manage, Group
      end
    end
  end
end
