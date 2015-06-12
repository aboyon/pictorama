require 'mini_magick'
namespace :picturama do
  namespace :thumbnail do

    desc "Generate thumbnail for a given folder or just a single file"
    task :generate, :source do |t, args|
      if File.directory?(args[:source]) || File.exists?(args[:source])
        size = Picturama::config['thumnail_default_size']
        album = Picturama::Album.new(:folder => args[:source])
        puts "Generating #{album.count_pictures} thumbnails for folder #{args[:source]}..."
        puts "Size: #{size}"
        unless album.has_broken_thumbnails?
          puts "WARNING: Seems that this album has all his thumbnails properly generated. There are no broken thumbs."
        end
        album.init_thumbnails
        album.pictures.each do |picture|
          unless picture.has_thumbnail?
            thumb = MiniMagick::Image.open(picture.path)
            thumb.resize "#{size}"
            thumb.format "jpg"
            thumb.write picture.thumbnail
            puts "Thumbnail generated for source #{File.basename(picture.path)}. Target destination #{File.basename(picture.thumbnail)}"
          end
        end
      else
        puts "Error => target destination #{args[:source]} does not exist"
      end
    end

  end
end