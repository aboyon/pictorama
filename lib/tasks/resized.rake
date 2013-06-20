require 'mini_magick'

namespace :resized do

  desc "Generate resized pictures for a given folder or just a single file"
  task :generate, :source do |t, args|
    if File.directory?(args[:source]) || File.exists?(args[:source])
      size = Picturama::config['resized_default_size']
      album = Picturama::Album.new(:folder => args[:source])
      puts "Generating #{album.count_pictures} resized for folder #{args[:source]}..."
      puts "Size: #{size}"
      album.init_resized
      album.pictures.each do |picture|
        unless picture.has_resized?
          pic = MiniMagick::Image.open(picture.path)
          pic.resize "#{size}"
          pic.format "jpg"
          pic.write picture.resized
          puts "Resized picture generated for source #{File.basename(picture.path)}. Target destination #{File.basename(picture.resized)}"
        end
      end
    else
      puts "Error => target destination #{args[:source]} does not exist"
    end
  end

end