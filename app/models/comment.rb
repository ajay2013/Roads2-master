class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  attr_accessible :content, :commentable

  validates :user, :presence => true
  validates :commentable, :presence => true
  validates :content, :presence => true
end
