class Micropost < ActiveRecord::Base
  # only the content is available to the web
  attr_accessible :content
  
  # every micropost belongs to one and only one user
  belongs_to :user
  
  # we want retrieval of the microposts to default to reverse order (DESCending) 
  #  of creation time
  default_scope :order => 'microposts.created_at DESC'

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

end
