class Hit < ActiveRecord::Base
  
  belongs_to :target, :class_name => "User", :foreign_key => "target_id"
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  
  # @user.should have(1).error_on(:first_name)
  
  acts_as_state_machine :initial => :unassigned
  
  state :unassigned
  state :assigned
  state :completed, :after => Proc.new { |hit| hit.target.kill! }
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


# == Schema Info
# Schema version: 20090114013851
#
# Table name: hits
#
#  id          :integer(4)      not null, primary key
#  assigned_to :integer(4)
#  state       :string(255)
#  target      :integer(4)
#  created_at  :datetime
#  updated_at  :datetime