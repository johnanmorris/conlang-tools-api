class Syllable < ActiveRecord::Base
  validates :pattern, presence: true

  belongs_to :language
end
