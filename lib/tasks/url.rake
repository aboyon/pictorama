namespace :url do
  desc "Normalize album names name for URL format"
  task :sluglify, :source do |t, args|
    albums = Picturama::albums(args[:source])
    puts "In folder #{args[:source].inspect} I'm moving..."
    albums.each do |album|
      target_folder = "#{args[:source]}/#{album.folder.to_url}"
      unless File.directory?(target_folder)
        FileUtils.mv "#{args[:source]}/#{album.folder}", "#{target_folder}"
        puts "#{album.folder.inspect} to #{album.folder.to_url.inspect}"
      end
    end
  end
end
