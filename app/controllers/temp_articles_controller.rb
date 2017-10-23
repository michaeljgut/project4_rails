class TempArticlesController < ApplicationController
  before_action :authenticate_user!
#  before_action :authenticate_user!, except: [ :index, :create, :show, :destroy]
  # def index
  #     @articles = Article.all()
  #     render json: @articles
  # end
  def create
      puts 'params = ', params
      @tempArticle = TempArticle.create(
          title: params[:title],
          url: params[:url],
          publication_date: params[:publication_date],
          user_id: params[:user_id],
          search_unit: params[:search_unit]
      )
      render json: { tempArticle: @tempArticle }
  end

  def show
    puts 'user id = ', current_user
    puts 'user id = ', params[:user_id]
    puts 'id = ', params[:id]

    @tempArticles = TempArticle.where(user_id: params[:user_id])
      render json: @tempArticles
  end

  def index
    puts 'user id = ', current_user
    puts 'user id = ', params[:user_id]
    @tempArticles = TempArticle.where(user_id: params[:user_id])
      render json: @tempArticles
  end

  def destroy
    TemppArticle.destroy(params[:id])
    # render json: Article.all
  end
end
