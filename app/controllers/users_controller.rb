class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome to BlogApp, #{@user.username}"
            redirect_to users_path
        else
            render 'new'
        end
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "#{@user.username}, your profiles was successfully edited."
            redirect_to user_path(@user)
        else
            render 'edit'
        end
    end
    
    def show
        @user = User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 4)
    end
    
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
