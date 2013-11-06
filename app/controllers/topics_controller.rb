class TopicsController < ApplicationController



  def index
    @topics = Topic.all()
    
  end

  def show
    @id = params[:id]
    @topic = Topic.find(@id)
    @comment = Comment.new() #for the form partial
    @comments = @topic.comments


  end

end
