class ArticlesController < ApplicationController
   
    
    def show
        @article = Article.find(params[:id])
    end
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @article = Article.new
    end
    
    def create
       @article = Article.new(params.require(:article).permit(:title, :description))
       @article.user_id = User.first.id
       if @article.save
           flash[:notice] = "Article was created successfully."
           redirect_to articles_path 
       else
           render 'new'
       end
    end
    
    def edit
         @article = Article.find(params[:id])
    end
    
    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was successfully edited."
            redirect_to article_path
        else
            render 'edit'
        end
    end
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
         flash[:notice] = "#{@article.title} was successfully deleted."
        redirect_to articles_path
    end
    
end