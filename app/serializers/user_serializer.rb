class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password

  # def email
  #   object.email
  # end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
