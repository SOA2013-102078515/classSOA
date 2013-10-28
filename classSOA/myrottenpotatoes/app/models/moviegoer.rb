class Moviegoer < ActiveRecord::Base
  has_many :reviews
  has_many :movies, :through => :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name
  # attr_accessible :title, :body
 def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  moviegoer = Moviegoer.where(:provider => auth.provider, :uid => auth.uid).first
  unless moviegoer
    moviegoer = Moviegoer.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
  end
  moviegoer
 end
 def self.new_with_session(params, session)
    super.tap do |moviegoer|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        moviegoer.email = data["email"] if moviegoer.email.blank?
      end
    end
  end
end
