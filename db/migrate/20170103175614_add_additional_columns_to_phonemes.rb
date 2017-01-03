class AddAdditionalColumnsToPhonemes < ActiveRecord::Migration
  def change
    add_column(:phonemes, :consonant, :boolean)
    add_column(:phonemes, :front, :boolean)
    add_column(:phonemes, :high, :boolean)
  end
end
