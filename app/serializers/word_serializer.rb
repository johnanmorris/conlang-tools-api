class WordSerializer < ActiveModel::Serializer
  attributes :id, :form, :translation, :language_id
end
