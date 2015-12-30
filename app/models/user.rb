class User < ActiveRecord::Base
  has_many :notes
  def self.from_omniauth(auth)
    access_token = auth.credentials.token

    facebook = Koala::Facebook::API.new(access_token)
    public_attr = facebook.get_object("me") 

     if !exists?(uid: auth.uid)
      User.new.tap do |user|
        user.uid = auth.uid
        user.provider = auth.provider
        user.email = auth.info.email
        user.name = auth.info.name
        user.gender = auth.extra.raw_info.gender
        user.save!
      end
    end
      where(uid: auth.uid).first.tap do |user|
        puts "--debug print out"
        puts auth 
        puts auth.info
        user.oauth_token = auth.credentials.token
        user.image = auth.info.image
        user.link= auth.extra.raw_info.link
        user.save!
    end
  end
end
