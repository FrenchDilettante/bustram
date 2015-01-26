Dir.mktmpdir do |dir|
  system "unzip ./db/data.zip -d #{dir}"

  dir = dir + '/20141222-20150208'

  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute 'truncate locations;'
    ActiveRecord::Base.connection.execute 'truncate routes;'
    ActiveRecord::Base.connection.execute 'truncate stops;'
    ActiveRecord::Base.connection.execute 'truncate schedules;'
    ActiveRecord::Base.connection.execute 'truncate timeframes;'
    ActiveRecord::Base.connection.execute 'truncate trips;'
  end

  puts 'Parsing timeframes'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/calendar.txt", "r").each_line do |line|
      if line.start_with? 'service_id' then next end

      Timeframe.import line
    end
  end

  puts "#{Timeframe.all.count} timeframes imported"


  puts 'Parsing routes'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/routes.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'route_id' then next end

      Route.import line
    end
  end

  puts "#{Route.all.count} routes imported"


  puts 'Parsing stops'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/stops.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'stop_id' then next end

      Stop.import line
    end
  end

  puts "#{Stop.all.count} stops imported"


  puts 'Parsing trips'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/trips.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'route_id' then next end

      Trip.import line
    end
  end
  
  puts "#{Trip.all.count} trips imported"


  puts 'Parsing schedules'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/stop_times.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'trip_id' then next end

      Schedule.import line
    end
  end

  puts "#{Schedule.all.count} schedules imported"

end
