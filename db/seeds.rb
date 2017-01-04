require "csv"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'phonemes.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

csv.each do |row, cell|
  phone = Phoneme.new
  # Converting strings to booleans
  # and saving their values as params
  if row[cell].to_s == "TRUE"
    row[cell] = true
  elsif row[cell].to_s == "FALSE"
    row[cell] = false
  end

  phone.consonant = row['consonant']
  phone.front = row['front']
  phone.high = row['high']
  phone.syllabic = row['syllabic']
  phone.low = row['low']
  phone.back = row['back']
  phone.voice = row['voice']
  phone.ipa = row['ipa']
  phone.place = row['place']
  phone.manner = row['manner']
  phone.save
  puts "#{phone.ipa} saved"
end


lang = Language.new(name: "Nikana")
sounds = ["p", "b", "t", "d", "k", "g", "m", "n", "ŋ",
  "f", "v", "s", "z", "ʃ", "ʒ", "h", "l", "r", "a", "e", "i", "o", "u"]
phonemes = []

sounds.each do |letter|
  ph = Phoneme.find_by(ipa: letter)
  lang.phonemes << ph
end

lang.save
