class Status < ActiveRecord::Base
    belongs_to :project
    validates  :body, presence: true
end