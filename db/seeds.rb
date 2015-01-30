Dir.mktmpdir do |dir|
  system "unzip ./db/data.zip -d #{dir}"

  dir = dir + '/20141222-20150208'

  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute 'truncate locations;'
    ActiveRecord::Base.connection.execute 'truncate routes;'
    ActiveRecord::Base.connection.execute 'truncate routes_stops;'
    ActiveRecord::Base.connection.execute 'truncate stops;'
    ActiveRecord::Base.connection.execute 'truncate schedules;'
    ActiveRecord::Base.connection.execute 'truncate timeframes;'
    ActiveRecord::Base.connection.execute 'truncate trips;'
  end

  location_ids = Hash.new
  route_ids = Hash.new
  stop_ids = Hash.new
  timeframe_ids = Hash.new
  trip_ids = Hash.new

  puts 'Parsing timeframes'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/calendar.txt", "r").each_line do |line|
      if line.start_with? 'service_id' then next end

      timeframe = Timeframe.import line
      timeframe_ids[timeframe.code] = timeframe.id
    end
  end

  puts "#{Timeframe.all.count} timeframes imported"


  puts 'Parsing routes'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/routes.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'route_id' then next end

      route = Route.import line
      route_ids[route.code] = route.id
    end
  end

  puts "#{Route.all.count} routes imported"


  puts 'Parsing stops'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/stops.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'stop_id' then next end

      stop = Stop.import line
      stop.locations.each do |location|
        location_ids[location.code] = location.id
        stop_ids[location.code] = stop.id
      end
    end
  end

  puts "#{Stop.all.count} stops imported"


  puts 'Parsing trips'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/trips.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'route_id' then next end

      trip = Trip.import line, route_ids, timeframe_ids
      trip_ids[trip.code] = trip.id
    end
  end
  
  puts "#{Trip.all.count} trips imported"


  puts 'Parsing schedules'
  ActiveRecord::Base.transaction do
    File.open("#{dir}/stop_times.txt", "r:iso-8859-1").each_line do |line|
      if line.start_with? 'trip_id' then next end

      Schedule.import line, location_ids, stop_ids, trip_ids
    end
  end

  puts "#{Schedule.all.count} schedules imported"


  puts 'Mapping stops to routes'

  ActiveRecord::Base.connection.execute '
    insert into routes_stops (stop_id, route_id)
    select distinct stop_id, route_id
    from schedules
    inner join trips on (schedules.trip_id = trips.id)
    order by 1, 2'

end
