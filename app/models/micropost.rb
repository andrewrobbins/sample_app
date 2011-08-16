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

#  def self.from_users_followed_by(user)
#    where(:user_id => user.following.push(user))
#  end

  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private
    def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships
      					WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
        { :user_id => user })
    end


end
