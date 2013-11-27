class TopicsController < ApplicationController
  before_filter :require_user, :only => :show



  def index
    @topics = Topic.all()
    
  end

  def show
    @id = params[:id]
    @topic = Topic.find(@id)

    @comment = Comment.new() #for the form partial
    @comment.topic = @topic
    @comment.user = current_user
    @comments = @topic.comments


    #if there is an old vote we just need to update
    @old_vote = Vote.where({:user_id => current_user, :topic_id => @id}).first

    if (@old_vote)
      @vote = @old_vote
    else
      @vote = Vote.new()
      @vote.topic = @topic
      @vote.user = current_user
    end

  end

end
