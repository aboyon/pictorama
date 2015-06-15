require 'ext/string'
require 'stringex'
require 'fileutils'
require 'pry'
require 'picturama/album'
require 'picturama/picture'
require 'picturama/version'

module Picturama

  Dir["lib/picturama/*.rb"].each { |file| require "#{Dir.pwd}/#{file}" }

  def self.config
    YAML.load_file('config/picturama.yml')['picturama']
  end

  def self.albums(album_source)
    [].tap { |albums|
      Dir["#{album_source}/*"].each { |album|
        if File.directory?(album)
          potential_album = Picturama::Album.new(:folder => album)
          albums << potential_album if potential_album.valid?
        end
      }
    }
  end

end