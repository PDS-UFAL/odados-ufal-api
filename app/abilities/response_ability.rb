# frozen_string_literal: true

class ResponseAbility
  include CanCan::Ability

  def initialize(user, form_send)
    if user.admin?
      can :manage, :all
    elsif user.active?
      can :create, Response if form_send.can_respond?(user)
      can :answers, Response if form_send.allowed_in_the_form?(user)
    end
  end
end
