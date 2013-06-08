require 'picturama'

module Picturama
  class Album
    
    def initialize(args)
      @folder = args[:folder]
      @thumbnails = "#{args[:folder]}/thumbnails"
      @resized = "#{args[:folder]}/resized"
    end

    def pictures(order = true)
      if File.directory?(@folder)
        list = []
        filter = "#{@folder}/*.{#{Picturama::config['allowed_formats'].join(',')}}"
        dir_list = generate_sorting(filter)
        dir_list.each do |picture|
          list.push(Picturama::Picture.new(picture))
        end
        unless order
          list.reverse!
        end
        list
      end
    end

    def folder
      File.basename(@folder)
    end

    def name
      folder.humanize
    end

    def slug
      name.to_url
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
      unless has_thumbnails?
        FileUtils.mkdir_p "#{@thumbnails}"
      end
    end

    def init_resized
      unless has_resized?
        FileUtils.mkdir_p "#{@resized}"
      end
    end

    protected

    def generate_sorting(filter)
      if (filter == :size)
        dir_list = Dir[filter].sort_by{ |filename| File.size("#{filename}") }
      else
        dir_list = Dir[filter].sort_by{ |filename| File.ctime("#{filename}") }
      end
      dir_list
    end

  end
end