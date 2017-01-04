class PhonemeSerializer < ActiveModel::Serializer

  # Modify serialize_hash to exclude nil values
  def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
    hash = super
    hash.each { |key, value| hash.delete(key) if value.nil? }
    hash
  end

  attributes :ipa, :voice, :consonant, :place, :manner, :high, :front
end
