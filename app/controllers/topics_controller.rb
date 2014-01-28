class TopicsController < ApplicationController
  before_filter :require_user, :only => :show



  def index
    @topics = Topic.all()

    session[:filter_param] = params[:filter] if params[:filter]
    if(session[:filter_param] and session[:filter_param]!="no")
      @topics_filtered = [];
      @topics.each do |t|
        if t.has_tag(session[:filter_param])
          @topics_filtered.push t
        end
      end
      @topics = @topics_filtered
    end

    session[:sort_param] = params[:sort] if params[:sort]
    if(session[:sort_param] and session[:sort_param]!="no")
       case session[:sort_param]
       when "Bewertungen" 
         then @topics.sort! {|a,b| b.rating <=> a.rating}
       when "Kommentare"
         then @topics.sort! {|a,b| b.date_of_last_comment <=> a.date_of_last_comment}
       end
    end
    
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


  def update

    @data = params[:topic]
    @topic = params[:id]

  end

  def edit

    @id = params[:id]
    @topic = Topic.find(@id)
    @comments = @topic.comments

  end

end
