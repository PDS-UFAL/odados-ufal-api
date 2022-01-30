module Form::Stateable
  extend ActiveSupport::Concern
  
  included do
    include AASM

    aasm column: :status, enum: true do
      state :open, initial: true
      state :closed, :not_started
      
      event :start do
        transitions from: :not_started, to: :open
      end

      event :close do
        transitions from: :open, to: :closed
      end

      event :reopen do
        transitions from: :closed, to: :open
      end
    end
  end
end