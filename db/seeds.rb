Dir.mktmpdir do |dir|
  system "unzip ./db/data.zip -d #{dir}"

  ActiveRecord::Base.connection.execute 'truncate routes;'
  ActiveRecord::Base.connection.execute 'truncate stops;'

  puts 'Parsing routes'

  File.open("#{dir}/routes.txt", "r").each_line do |line|
    if line.start_with? 'route_id' then next end

    Route.import(line).save!
  end

  puts "#{Route.all.count} routes imported"


  puts 'Parsing stops'

  File.open("#{dir}/stops.txt", "r").each_line do |line|
    if line.start_with? 'stop_id' then next end

    Stop.import(line).save!
  end

  puts "#{Stop.all.count} stops imported"

end
