class TopicsController < ApplicationController



  def index
    @topics = Topic.all()
    
  end

  def view
    @id = params(:id)
    @topic = Topic.find(@id)
    @comments = @topic.comments


  end

end
