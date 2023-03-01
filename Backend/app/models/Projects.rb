class Project < ActiveRecord::Base 
    belongs_to :user
    has_many :statuses
    has_many :project_memberships
    has_many :members, through: :project_memberships, source: :user
    validates :name,presence: true

end