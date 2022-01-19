class EventSerializer < ActiveModel::Serializer
  attributes :id, :age, :title, :episode, :happiness
end
