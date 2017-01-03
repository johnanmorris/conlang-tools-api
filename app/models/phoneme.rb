class Phoneme < ActiveRecord::Base
  validates :ipa, presence: true
  validates :voice, inclusion: { in: [true, false] }
  validates :consonant, inclusion: { in: [true, false] }
  
  has_and_belongs_to_many :languages

end
