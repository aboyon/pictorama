require 'picturama'

module Picturama
  class Album
    
    def initialize(args)
      @folder = args[:folder]
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

    def name
      File.basename(@folder).humanize
    end

    def count_pictures
      pictures.size
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