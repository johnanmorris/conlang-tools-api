class AddLowBackAndTenseToPhonemes < ActiveRecord::Migration
  def change
    add_column(:phonemes, :syllabic, :boolean)
    add_column(:phonemes, :low, :boolean)
    add_column(:phonemes, :back, :boolean)
    add_column(:phonemes, :tense, :boolean)
  end
end
