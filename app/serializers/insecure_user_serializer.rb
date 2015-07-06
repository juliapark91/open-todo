class InsecureUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password

  def email
    object.(self.email)
  end
end