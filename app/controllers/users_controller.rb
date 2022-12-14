class UsersController < ApplicationController

    def index
        user = User.all 
        render json: user 
    end

    # def show
    #     user = User.find(params[:id])
    #     render json: user, status :ok
    # end
    
    
    
    def show
        if current_user
            render json: current_user, status: :ok
        else
            render json: "Not autheticated", status: :unauthorized
        end
    end



    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id 
            render json: user, status: :ok
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end



private

def user_params
    params.permit(:email, :password)
end

def current_user
    User.find_by_id(session[:user_id])
  end


end
