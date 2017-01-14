class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :form
      t.string :translation
      t.belongs_to :language, index: true
      t.timestamps null: false
    end
  end
end
