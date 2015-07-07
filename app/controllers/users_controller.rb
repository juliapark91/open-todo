class Api::UsersController < ApiController
  def index
    return permission_denied_error unless conditions_met

    users = User.all

    render json: users, each_serializer: InsecureUserSerializer
  end

  private

  def conditions_met
    true
  end
end