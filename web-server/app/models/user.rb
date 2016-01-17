class User < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "user_id",
                                  dependent: :destroy
  has_many :groups, through: :active_relationships, source: :group
  validates_uniqueness_of :username

  def join_group(group)
    if !active_relationships.find_by(group_id: group.id)
      active_relationships.create(group_id: group.id)
    end
  end

  def leave_group(group)
    if active_relationships.find_by(group_id: group.id)
      active_relationships.find_by(group_id: group.id).destroy
    end
  end
end
