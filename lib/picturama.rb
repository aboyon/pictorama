module Picturama

  Dir["lib/picturama/*.rb"].each { |file| 
    require "#{Dir.pwd}/#{file}"
  }

  def self.config
    YAML.load_file('config/config.yml')['picturama']
  end

  def self.albums(album_source)
    albums = []
    Dir["#{album_source}/*"].each { |album|
      if File.directory?(album)
        potential_album = Picturama::Album.new(:folder => album)
        albums.push(album)
      end
    }
    albums
  end

end