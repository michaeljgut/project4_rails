class TempArticlesController < ApplicationController
  before_action :authenticate_user!
#  before_action :authenticate_user!, except: [ :index, :create, :show, :destroy]
  def create
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
    @tempArticles = TempArticle.where('user_id = ? AND search_unit = ?',
      params[:user_id], params[:unit_no]).order(publication_date: :desc, title: :asc)
    render json: @tempArticles
  end

  def show
    @tempArticle = TempArticle.find(params[:id])
    render json: @tempArticle
  end

  def destroy
    TemppArticle.destroy(params[:id])
  end

  def destroy_some
    TempArticle.where('user_id = ? AND search_unit = ? AND created_at < ?',
      params[:user_id], params[:unit_no], 12.hours.ago).destroy_all
  end

  def destroy_temp
    TempArticle.where('user_id = ? AND search_unit = ?',
      params[:user_id], params[:unit_no]).destroy_all
  end

end
