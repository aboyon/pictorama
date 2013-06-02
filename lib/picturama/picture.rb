require 'picturama'

module Picturama
  class Picture < File
    
    attr_accessor :thumbnail

    def initialize(args)
      super
      @thumbnail = "#{File.dirname(path)}/thumb_#{File.basename(path)}"
      @resized = "#{File.dirname(path)}/resized_#{File.basename(path)}"
      @metainfo = "#{File.dirname(path)}/resized_#{File.basename(path)}.info"
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

  end
end