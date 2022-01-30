# frozen_string_literal: true

class ResponseAbility
  include CanCan::Ability

  def initialize(user, form)
    can :manage, :all if user.admin?
    can :create, Response if form.can_respond?(user)
    can :answers, Response if form.allowed_in_the_form?(user)
  end
end
