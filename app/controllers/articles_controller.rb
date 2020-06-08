class ArticlesController < ApplicationController
   before_action :set_article, only: [:show, :edit, :update, :destroy]
   before_action :require_login, except: [:index, :show]
   before_action :require_user, only: [:edit, :update, :destroy]
  
    
    def show
    end
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @article = Article.new
    end
    
    def create
       @article = Article.new(params.require(:article).permit(:title, :description))
       @article.user_id = current_user.id
       if @article.save
           flash[:notice] = "Article was created successfully."
           redirect_to article_path(@article) 
       else
           render 'new'
       end
    end
    
    def edit
    end
    
    def update
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was successfully edited."
            redirect_to article_path
        else
            render 'edit'
        end
    end
    
    def destroy
        @article.destroy
         flash[:notice] = "#{@article.title} was successfully deleted."
        redirect_to articles_path
    end
    
    private
    
    def set_article
        @article = Article.find(params[:id])
    end
    
    def require_user
        if current_user != @article.user
            flash[:alert] = "You cannot change an article that you don't own."
            redirect_to articles_path
        end
    end
    
end