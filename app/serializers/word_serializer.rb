class WordSerializer < ActiveModel::Serializer
  attributes :id, :form, :translation, :language_id
  belongs_to :language
end
