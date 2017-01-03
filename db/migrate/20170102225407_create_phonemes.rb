class CreatePhonemes < ActiveRecord::Migration
  def change
    create_table :phonemes do |t|
      t.string :ipa

      t.timestamps null: false
    end
  end
end
