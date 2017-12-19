class ArticlesController < ApplicationController
  before_action :authenticate_user!
#  before_action :authenticate_user!, except: [ :index, :create, :show, :destroy]
  def create
    @article = Article.create(
        title: params[:title],
        url: params[:url],
        publication_date: params[:publication_date],
        user_id: params[:user_id]
    )
    render json: { article: @article }
  end

  def show
    @article = Article.find(params[:id])
    render json: @article
  end

  def index
    @articles = Article.where(user_id: params[:user_id]).order(publication_date: :desc, title: :asc)
    render json: @articles
  end

  def destroy
    Article.destroy(params[:id])
    # render json: Article.all
  end
end
