class CreateJoinTableForLanguagesPhonemes < ActiveRecord::Migration
  def change
    create_join_table :languages, :phonemes, id:false do |t|
      t.index [:language_id, :phoneme_id]
      t.index [:phoneme_id, :language_id]
    end
  end
end
