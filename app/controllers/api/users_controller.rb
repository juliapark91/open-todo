module API

  class UsersController < APIController
    
    before_action :authenticated?

    def index
      @users = User.all
      
      render json: @users, each_serializer: UserSerializer
    end
  
    def create 
      @user = User.new( user_params )
      
      if @user.save
        render json: { success: "user sucessfully created" }, status: :created
      else
        render json: { failure: "invalid username or password" }, status: :unprocessable_entity
      end
    end

    def destroy
      begin
        user = User.find(params[:id])
        user.destroy
        render json: {}, status: :no_content
      rescue ActiveRecord::RecordNotFound
        render :json => {}, :status => :not_found
      end
    end
    
  private 
  
    def user_params
      params.require( :user ).permit( :username, :password )
    end

  end
  
end
