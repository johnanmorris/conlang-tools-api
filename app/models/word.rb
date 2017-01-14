class Word < ActiveRecord::Base
  validates :form, presence: true
  validates :translation, presence: true

  belongs_to :language
end
