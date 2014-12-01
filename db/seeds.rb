Dir.mktmpdir do |dir|
  system "unzip ./db/data.zip -d #{dir}"

  ActiveRecord::Base.transaction do
    ActiveRecord::Base.connection.execute 'truncate locations;'
    ActiveRecord::Base.connection.execute 'truncate routes;'
    ActiveRecord::Base.connection.execute 'truncate stops;'
    ActiveRecord::Base.connection.execute 'truncate timeframes;'

    puts 'Parsing timeframes'

    File.open("#{dir}/calendar.txt", "r").each_line do |line|
      if line.start_with? 'service_id' then next end

      Timeframe.import line
    end

    puts "#{Timeframe.all.count} timeframes imported"


    puts 'Parsing routes'

    File.open("#{dir}/routes.txt", "r").each_line do |line|
      if line.start_with? 'route_id' then next end

      Route.import line
    end

    puts "#{Route.all.count} routes imported"


    puts 'Parsing stops'

    File.open("#{dir}/stops.txt", "r").each_line do |line|
      if line.start_with? 'stop_id' then next end

      Stop.import line
    end

    puts "#{Stop.all.count} stops imported"


    puts 'Parsing trips'

    File.open("#{dir}/trips.txt", "r").each_line do |line|
      if line.start_with? 'route_id' then next end

      Trip.import line
    end

    puts "#{Trip.all.count} trips imported"

  end
end
