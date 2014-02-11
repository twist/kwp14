class VotesController < ApplicationController

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end
  def create
    @vote = Vote.new(params[:vote])
    respond_to do |format|
      if @vote.save
        @vote.topic.recalculate_rating
        @vote.topic.save!
        format.html { redirect_to topics_path(:anchor => "topic_#{@vote.topic_id}"), notice: "Sie haben mit \"#{@vote.value}\" abgestimmt" }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { redirect_to :back, notice: "Sie koennen keine leeren Bewertungen abgeben" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        @vote.topic.recalculate_rating
        @vote.topic.save!
        format.html { redirect_to topics_path(:anchor => "topic_#{@vote.topic_id}"), notice: "Sie haben mit \"#{@vote.value}\" abgestimmt" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    #@vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end
end
