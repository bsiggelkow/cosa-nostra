class Hit < ActiveRecord::Base
  
  belongs_to :target, :class_name => "User"
  belongs_to :assigned_to, :class_name => "User"
  
  acts_as_state_machine :initial => :unassigned
  
  state :unassigned
  state :assigned
  state :completed, :after => Proc.new { |hit| hit.target.user_status.name = UserStatus.deceased }
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
