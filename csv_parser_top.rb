require 'csv'

class County
  def initialize(name, estimate, percent)
    @name = name
    @estimate = estimate
    @percent = percent
  end

  def name
    @name
  end

  def estimate
    @estimate
  end

  def percent
    @percent
  end

end

no_veh_estimate_col = -1
no_veh_perc_col = -1
county_col = 2
counties = []

  counter = 0
  CSV.foreach("./data/ACS_11_5YR_DP04_with_ann.csv") do |row|
    counter+=1
    if (counter == 1)
  	  no_veh_estimate_col = row.index("HC01_VC82")
  	  no_veh_perc_col = row.index("HC03_VC82")
    elsif (no_veh_estimate_col >= 0 && no_veh_perc_col >= 0)
      perc = row[no_veh_perc_col] == "-" ? 0 : row[no_veh_perc_col]
      county = County.new(row[county_col], row[no_veh_estimate_col], perc)
      counties.push(county)
  	else
      puts "error parsing: could not find proper columns"
    end
  end

counties.sort! { |a,b| b.estimate.to_i <=> a.estimate.to_i }

File.open("data.json", 'w') do |f|
  i = 1
  f.write "["
  counties.each do |county|
    f.write "," unless (i == 1)
    f.write "{\"county\": \"#{county.name}\", \"estimate\": #{county.estimate}, \"percent\": #{county.percent}}"
    if (i == 10)
      break;
    end
    i+=1
  end
  f.write "]"
end