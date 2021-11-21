class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  # TODO: Here we are using the before_action method to check if the user is logged in
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    # TODO: PAG1 Pagination added here
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])  
    end
  
    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end
  
    # TODO: Here we are using the require_same_user method to check if the user is the same as the one who created the article
    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to root_path
      end
    end
  
end