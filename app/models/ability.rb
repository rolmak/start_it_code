class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= current_user
    if user.is_admin?
      can :manage, :all
    end
  end
end
