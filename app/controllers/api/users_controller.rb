module API
  
  class UsersController < APIController
    
    # before_action :authenticated?, only: [:index]
    #
    # def index
    #   users = User.all
    #
    #   render json: users, each_serializer: InsecureUserSerializer
    # end
    
    def create
      user = User.new( user_params )
      
      if user.save
        render json: { success: "user sucessfully created" }, status: :created
      else
        render json: { failure: "invalid e-mail or password" }, status: :unprocessable_entity
      end
    end
  
  private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
  
  end
  
end
