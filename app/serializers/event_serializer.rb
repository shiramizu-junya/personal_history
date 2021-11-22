class EventSerializer < ActiveModel::Serializer
  attributes :id, :age, :title, :category_id, :category_name, :episode, :happiness

  def category_name
    object.category.name
  end
end
