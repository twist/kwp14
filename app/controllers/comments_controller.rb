class CommentsController < ApplicationController
  before_filter :require_user

  def create
    @data = params[:comment]

    c = Comment.new(@data);
    c.save!

    
    redirect_to request.referer 


  end

  def index

    @comments = Comment.all().reverse;

  end

  def new

    @comment = Comment.new();


  end
end
