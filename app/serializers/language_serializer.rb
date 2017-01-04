class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :phoneme_list
  #displays phonemes belonging to language
  has_many :phonemes

  def phoneme_list
    phoneme_array =[]
    object.phonemes.each do |phone|
      phoneme_array << phone.ipa
    end
    return phoneme_array
  end
end
