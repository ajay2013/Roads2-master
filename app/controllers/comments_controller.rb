class CommentsController < InheritedResources::Base
  actions :create, :destroy
  belongs_to :trip, :polymorphic => true

  def create
    create! do |success, failure|
      failure.html { redirect_to parent_url }
    end
  end

protected
  def end_of_association_chain
    super.where :user_id => current_user.id
  end
end
