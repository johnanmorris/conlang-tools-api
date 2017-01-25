class Language < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :phonemes
  has_many :syllables
  has_many :words
end
