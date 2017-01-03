class CreateSyllables < ActiveRecord::Migration
  def change
    create_table :syllables do |t|
      t.belongs_to :language, index: true
      t.string :pattern
      t.timestamps null: false
    end
  end
end
