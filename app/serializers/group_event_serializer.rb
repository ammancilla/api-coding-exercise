class GroupEventSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :description, :location, :start_on, :end_on, :duration, :published, :removed 

  def published
    object.published?
  end
end