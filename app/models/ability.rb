# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can [:read, :update], User, id: user.id

      if user.admin?
        can :manage, :all
      elsif user.employee?
        can :update, Form
      end
    end
  end
end
