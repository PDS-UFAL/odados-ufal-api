# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can [:read, :update, :me], User, id: user.id

      if user.admin?
        can :manage, :all
      elsif user.employee?
        can :read, Form
        can :read, Sector, id: user.sector_id
      end
    end
  end
end
