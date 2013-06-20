require 'picturama'

module Picturama
  class Picture < File
    
    attr_accessor :thumbnail, :resized, :metainfo

    def initialize(args)
      super
      @thumbnail = "#{File.dirname(path)}/thumbnails/#{Picturama::config['thumbnail_prefix']}#{basename}"
      @resized = "#{File.dirname(path)}/resized/resized_#{basename}"
      @metainfo = "#{File.dirname(path)}/resized/resized_#{basename}.info"
    end

    def basename
      File.basename(path)
    end

    def info
      File.read(@metainfo) if File.exists?(@metainfo)
    end

    def has_resized?
      File.exists?(@resized)
    end

    def has_thumbnail?
      File.exists?(@thumbnail) && File.size(@thumbnail) < size
    end

    def remove_assoc
      File.delete(@thumbnail) if has_thumbnail?
      File.delete(@resized) if has_resized?
    end

    def type
      File.extname(path).split('.').last
    end

  end
end