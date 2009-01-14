class Role < ActiveRecord::Base
  has_many :permissions
  
  def has_permission?(name)
    return permissions.map(&:name).include?(name)
  end
end