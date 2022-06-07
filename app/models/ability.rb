# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.active?
        can [:read, :update, :me], User, id: user.id
      end

      if user.admin?
        can :manage, :all
      elsif user.employee? and user.active?
        can :read, FormSend, sectors: { id: user.sector.id }
        can :read, Sector, id: user.sector.id
        can :table, Form
      end
    end
  end
end
