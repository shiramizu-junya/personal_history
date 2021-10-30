class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :birthday, :gender
end
