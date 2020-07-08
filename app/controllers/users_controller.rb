class UsersController < ApplicationController
    
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_login, except: [:index, :show]
    before_action :require_user, only: [:edit, :update, :destroy]
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to BlogApp, #{@user.username}"
            redirect_to users_path
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:notice] = "#{@user.username}, your profiles was successfully edited."
            redirect_to user_path(@user)
        else
            render 'edit'
        end
    end
    
    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 4)
    end
    
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Your account and articles have successfully been deleted."
        redirect_to root_path
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id])  
    end
    
    def require_user
        if current_user != @user
            flash[:alert] = "You cannot change another user's details."
            redirect_to user_path(current_user)
        end
    end
end
