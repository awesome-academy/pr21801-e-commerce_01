class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    user ||= User.new
    case controller_namespace
      when "Admin"
        if user.role?
          can :manage, :all
          cannot :destroy, User do |user|
            user.role?
          end
        end
      else
        can :read, :all
        can :update, User, id: user.id
        can [:update, :destroy], [Like, Comment, Rating], user_id: user.id
    end
  end
end

