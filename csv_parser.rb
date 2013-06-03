require 'csv'

no_veh_estimate_col = -1
no_veh_perc_col = -1
county_col = 2

File.open("data.json", 'w') do |f|
  f.write "["
  counter = 0
  CSV.foreach("./data/ACS_11_5YR_DP04_with_ann.csv") do |row|
    counter+=1
    if (counter == 1)
  	  no_veh_estimate_col = row.index("HC01_VC82")
  	  no_veh_perc_col = row.index("HC03_VC82")
    elsif (no_veh_estimate_col >= 0 && no_veh_perc_col >= 0)
      f.write "," unless (counter ==2)
      perc = row[no_veh_perc_col] == "-" ? 0 : row[no_veh_perc_col]
  	  f.write "{\"county\": \"#{row[county_col]}\", \"estimate\": #{row[no_veh_estimate_col]}, \"percent\": #{perc}}"
  	else
      puts "error parsing: could not find proper columns"
    end
  end

  f.write "]"

end