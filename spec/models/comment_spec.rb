require 'spec_helper'

describe Comment do
  subject(:comment) { Comment.new }
  it { should validate_presence_of :content }
  it { should validate_presence_of :user }
  it { should validate_presence_of :commentable }
end
