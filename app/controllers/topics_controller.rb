class TopicsController < ApplicationController
#  before_action :authenticate_user!, except: [ :index, :create, :show, :destroy]
  before_action :authenticate_user!
  def create
    puts 'params = ', params
    @topic = Topic.where('user_id = ? AND search_unit = ? AND search_unit != 0', params[:user_id], params[:search_unit])
    puts '@topic = ',@topic
    if @topic.any?
      puts '@topic = ',@topic
      @topic.update_all(:name => params[:name],
                        :query_type => params[:query_type])
    else
      @topic = Topic.create(
          name: params[:name],
          user_id: params[:user_id],
          query_type: params[:query_type],
          search_unit: params[:search_unit]
      )
      # end
      # @users_topic = UsersTopic.create(
      #   user_id: params[:user_id],
      #   topic_id: @topic.id
      # )
      render json: { topic: @topic }
    end
  end

  def show
    puts 'user id = ', current_user
    puts 'user id = ', params[:user_id]

    @topics = Topic.where(id: params[:id])
      render json: @topics
  end

  def index
    puts 'user id = ', current_user
    puts 'user id = ', params[:user_id]
    # query = 'INNER JOIN users_topics ON users_topics.topic_id = topics.id
    #   WHERE users_topics.user_id = ' + params[:user_id]
    # puts 'query = ', query
    @topics = Topic.where('user_id = ? AND search_unit = ?', params[:user_id], 0)
#      render json: @topics
#    @topics = Topic.joins(query)
    render json: @topics
  end

  def index_save
    puts 'user id = ', current_user
    puts 'user id = ', params[:user_id]
    # query = 'INNER JOIN users_topics ON users_topics.topic_id = topics.id
    #   WHERE users_topics.user_id = ' + params[:user_id]
    # puts 'query = ', query
    @topics = Topic.where('user_id = ? AND search_unit = ?', params[:user_id], params[:unit_no])
#      render json: @topics
#    @topics = Topic.joins(query)
    render json: @topics
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      puts "OK"
      render json: @topic
    else
      raise "Error!"
    end
  end

  def destroy
    # @topic = Topic.find(params[:id])
    # if @topic.destroy(topic_params)
    #   puts "OK"
    # else
    #   raise "Error!"
    # end
    Topic.destroy(params[:id])
  end

  def destroy_save
    Topic.where('user_id = ? AND search_unit = ? AND created_at < ?',
      params[:user_id], params[:unit_no], 12.hours.ago).destroy_all
  end

  def topic_params
    params.permit(:name, :id)
  end

end
