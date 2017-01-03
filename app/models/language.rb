class Language < ActiveRecord::Base
  validates :name, presence: true
  
  has_and_belongs_to_many :phonemes
  has_many :syllables

  # ADD THIS WHEN THERE IS A USER MODEL:
  # belongs_to :user
end
