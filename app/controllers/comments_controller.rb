class CommentsController < ApplicationController
  before_filter :require_user

  def create
    @data = params[:comment]

    c = Comment.new(@data);
    c.save!

    
    if request.referer.nil?
      redirect_to topics_path
    else
      redirect_to request.referer 
    end


  end

  def index

    @comments = Comment.all().reverse;

  end

  def new

    @comment = Comment.new();


  end
end
