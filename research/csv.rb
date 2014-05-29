require 'csv'

CSV.open("myfile.csv", "w") do |csv|
  csv << ["user_name","text", "id", "CSV", "data"]
  # csv << ["another", "row"]
  # ...
end