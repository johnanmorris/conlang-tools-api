class PhonemeSerializer < ActiveModel::Serializer

  # Modify serializable_hash to exclude nil/null values
  def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
    hash = super
    hash.each { |key, value| hash.delete(key) if value.nil? }
    hash
  end

  attributes :ipa, :voice, :consonant, :place, :manner, :high, :front, :low, :back, :syllabic
end
