class CommentsController < ApplicationController

  def create
    @data = params[:comment]

    c = Comment.new(@data);
    c.save!

    
    redirect_to request.referer 


  end

  def new

    @comment = Comment.new();


  end
end
