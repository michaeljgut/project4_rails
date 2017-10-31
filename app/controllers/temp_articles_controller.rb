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

  def index
    puts 'user id = ', current_user
    puts 'user id = ', params[:user_id]
    puts 'id = ', params[:id]

    # @tempArticles = TempArticle.where(user_id: params[:user_id])
    @tempArticles = TempArticle.where('user_id = ? AND search_unit = ?',
      params[:user_id], params[:unit_no]).order(publication_date: :desc, title: :asc)
      render json: @tempArticles
  end

  def show
    @tempArticles = TempArticle.find(params[:id])
      render json: @tempArticles
  end

  def destroy
    TemppArticle.destroy(params[:id])
    # render json: Article.all
  end
  def destroy_some
    @tempArticles = TempArticle.where('user_id = ? AND search_unit = ? AND created_at < ?',
      params[:user_id], params[:unit_no], 12.hours.ago).destroy_all
  end
  def destroy_temp
    @tempArticles = TempArticle.where('user_id = ? AND search_unit = ?',
      params[:user_id], params[:unit_no]).destroy_all
  end
end
