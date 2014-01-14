class TopicsController < ApplicationController
  before_filter :require_user, :only => :show



  def index
    @topics = Topic.all()

    if(params[:filter])
      filter_param = params[:filter]
      @topics_filtered = [];
      @topics.each do |t|
        if t.has_tag(filter_param)
          @topics_filtered.push t
        end
      end
      @topics = @topics_filtered
    end

   # if(params[:sort]
   #    sort_param = params[:sort]
   #    case 
   #    @topics.sort! {|a,b| a.id <=> b.id}

   # end
    
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
