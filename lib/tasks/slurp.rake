namespace :slurp do
  desc "TODO"
  task values: :environment do
    
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "dt_clean.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
        v = Value.new
        v.indicator_id = Indicator.where(database_key: row["indicator"]).ids[0]
        v.date = row["date"]
        v.value = row["value"]
        v.save
        puts "#{v.indicator_id}, #{v.date}, #{v.value} saved"
    end

  puts "There are now #{Value.count} rows in the values table"
  end

end
