require 'picturama'

module Picturama
  class Album
    
    def initialize(args)
      @folder = args[:folder]
      @thumbnails = "#{args[:folder]}/thumbnails"
      @resized = "#{args[:folder]}/resized"
      @info = "#{args[:folder]}/.info.yml"
    end

    def pictures(order = :basename)
      [].tap do |list|
        filter = "#{@folder}/*.{#{Picturama::config['allowed_formats'].join(',')}}"
        Dir[filter].sort_by{ |filename| File.send(order, "#{filename}") }.each { |picture| 
          list << Picturama::Picture.new(picture)
        }
      end
    end

    def folder
      File.basename(@folder)
    end

    def name
      (info.nil?) ? name! : info['album']['title']
    end

    def name!
      folder.humanize
    end

    def slug
      name!.to_url
    end

    def count_pictures
      pictures.size
    end

    def has_thumbnails?
      File.directory?(@thumbnails)
    end

    def has_resized?
      File.directory?(@resized)
    end

    def has_broken_thumbnails?
      thumbnails_found = Dir["#{@thumbnails}/*.{#{Picturama::config['allowed_formats'].join(',')}}"].size
      !has_thumbnails? || thumbnails_found < count_pictures
    end

    def init_thumbnails
      FileUtils.mkdir_p("#{@thumbnails}", :mode => 0775) unless has_thumbnails?
    end

    def init_resized
      FileUtils.mkdir_p("#{@resized}", :mode => 0775) unless has_resized?
    end

    def info
      YAML.load_file(@info) if File.exists?(@info)
    end

    def valid?
      has_thumbnails? && !info.nil?
    end

  end
end