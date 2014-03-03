class Task < ActiveRecord::Base

  belongs_to :event
  belongs_to :user

  validates :event_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true

  state_machine :state, :initial => :ready do 

    event :do do 
      transition :ready => :doing
    end

    event :finish do
      transition :doing => :done
    end

    event :reject do
      transition :done => :doing
    end

    event :suspend do
      transition all => :suspending
    end
    
  end

  def can_edit?(user)
    (user.id == self.user_id) or user.has_role?(:admin)
  end

end
