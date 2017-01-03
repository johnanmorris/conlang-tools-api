class AddVoicePlaceMannerToPhonemes < ActiveRecord::Migration
  def change
    # add_column(table_name, column_name, data_type, options)

    add_column(:phonemes, :voice, :boolean)
    add_column(:phonemes, :place, :string)
    add_column(:phonemes, :manner, :string)
  end
end
