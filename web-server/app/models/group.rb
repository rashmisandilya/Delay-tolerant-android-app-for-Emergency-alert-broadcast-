class Group < ActiveRecord::Base
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "group_id",
                                  dependent: :destroy
  has_many :members, through: :active_relationships, source: :user
end
