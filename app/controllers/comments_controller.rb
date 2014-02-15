class CommentsController < ApplicationController
  before_filter :require_user


  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(:id => @comment.topic.id), notice: "Sie haben kommentiert" }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { redirect_to :back, notice: "Sie koennen keine leeren Kommentare abgeben" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
  def index

    @comments = Comment.all().reverse;

  end

  def new

    @comment = Comment.new();


  end
end
