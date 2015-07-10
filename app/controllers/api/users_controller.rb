class API::UsersController < APIController

  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer 
  end

  def create
    @user = User.new( user_params )
    
    if @user.save
      render json: @user, each_serializer: UserSerializer

    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
