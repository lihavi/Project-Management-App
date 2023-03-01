class User < ActiveRecord::Base
    has_many :projects
   # validates :username, presence: true, uniqueness: true
   # validates :password_digest, presence: true
end