module FormSector::Stateable
  extend ActiveSupport::Concern
  
  included do
    include AASM

    aasm column: :status, enum: true do
      state :waiting_response, initial: true
      state :answered, :waiting_resend, :closed
      
      event :respond do
        transitions from: [:waiting_response, :waiting_resend], to: :answered
      end

      event :reopen do
        transitions from: :closed, to: :waiting_resend
      end

      event :close do
        transitions to: :closed
      end
    end
  end
end