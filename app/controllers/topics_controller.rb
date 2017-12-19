class TopicsController < ApplicationController
#  before_action :authenticate_user!, except: [ :index, :create, :show, :destroy]
  before_action :authenticate_user!

  # If create is called for a temporary topic (search_unit != 0), first check if there's already one out
  # there for this unit, and if so then just update it. Otherwise, just go ahead with a normal create.
  # This is necessary as the topics table is used to store both saved and temporary topics.
  def create
    @topic = Topic.where('user_id = ? AND search_unit = ? AND search_unit != 0',
      params[:user_id], params[:search_unit])
    if @topic.any?
      @topic.update_all(:name => params[:name],
                        :query_type => params[:query_type])
    else
      @topic = Topic.create(
          name: params[:name],
          user_id: params[:user_id],
          query_type: params[:query_type],
          search_unit: params[:search_unit]
      )
      render json: { topic: @topic }
    end
  end

  def show
    @topics = Topic.where(id: params[:id])
    render json: @topics
  end

  # Search unit = 0 will retrieve all the premanent topics.
  def index
    @topics = Topic.where('user_id = ? AND search_unit = ?', params[:user_id], 0).order(created_at: :asc)
    render json: @topics
  end

  # This will return the single temporary topic for the current search unit.
  def index_save
    @topics = Topic.where('user_id = ? AND search_unit = ?',
      params[:user_id], params[:unit_no]).order(created_at: :asc)
    render json: @topics
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      render json: @topic
    else
      raise "Error!"
    end
  end

  def destroy
    Topic.destroy(params[:id])
  end

  # destroy_save will delete a temporary topic that is older than 12 hours.
  def destroy_save
    Topic.where('user_id = ? AND search_unit = ? AND created_at < ?',
      params[:user_id], params[:unit_no], 12.hours.ago).destroy_all
  end

  def topic_params
    params.permit(:name, :id)
  end

end
