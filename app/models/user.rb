class User < ActiveRecord::Base
  has_many :notes
  has_many :tags
  
  has_many :sections, through: :tags


  scope :create_by, ->(user){
      where "name like ?", "#{user}%"
  }
  
  def self.from_omniauth(auth)
    access_token = auth.credentials.token

    facebook = Koala::Facebook::API.new(access_token)
    public_attr = facebook.get_object("me?fields=id,name,email") 
    if !exists?(uid: auth.uid)
      User.new.tap do |user|
        user.uid = auth.uid
        user.provider = auth.provider
        user.email = public_attr["email"]
        user.name = auth.info.name
        user.gender = auth.extra.raw_info.gender
        user.save!
      end
    end
      where(uid: auth.uid).first.tap do |user|
        puts "--debug print out"
        puts auth 
        puts auth.info
        user.name = auth.info.name
        user.email = public_attr["email"]
        user.oauth_token = auth.credentials.token
        user.image = auth.info.image
        user.link= auth.extra.raw_info.link
        user.save!
    end
  end
  def self.anonymous
    if !exists?(uid: 'anonymous')
      User.new.tap do |user|
        user.name = '匿名'
        user.uid = 'anonymous'
        user.email = 'anonymous@oer.com.tw'
        user.save!
      end
    else
      @anonymous_user = where(uid: 'anonymous').first
    end
  end
end
