class Hit < ActiveRecord::Base
  
  belongs_to :target, :class_name => "User", :foreign_key => "target_id"
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  belongs_to :hit_method
  
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
  
  def assign(user)
    accept!
    update_attribute(:assigned_to, user)
  end
  
end

# == Schema Info
# Schema version: 20090114222108
#
# Table name: hits
#
#  id             :integer(4)      not null, primary key
#  assigned_to_id :integer(4)
#  hit_method_id  :integer(4)
#  target_id      :integer(4)
#  deadline       :datetime
#  state          :string(255)
#  created_at     :datetime
#  updated_at     :datetime