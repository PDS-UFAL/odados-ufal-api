# frozen_string_literal: true

class ResponseAbility
  include CanCan::Ability

  def initialize(user, form)
    can :create, Response if form.can_respond?(user)
  end
end
