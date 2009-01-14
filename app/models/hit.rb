class Hit < ActiveRecord::Base
  
  acts_as_state_machine :initial => :unassigned
  
  state :unassigned
  state :assigned
  state :completed
  state :failed
  
  event :accept do
    transitions :from => :unassigned, :to => :assigned
  end
  
  event :complete do
    transitions :from => :assigned, :to => :completed
  end
  
  event :fail do
    transitions :from => :assigned, :to => :failed
  end
  
  event :reassign do
    transitions :from => :failed, :to => :assigned
  end
  
end
