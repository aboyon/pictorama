require 'mini_magick'
require_relative '../lib/picturama'

describe "For a given picture in a given album" do 
  
  before :each do
    @target_exists_folder = "#{Dir.pwd}/spec/pictures"
    @picture = Picturama::Album.new(:folder => @target_exists_folder).pictures.first
    @thumb_w = 100
  end

  it "generate thumbnail" do
    @picture.has_thumbnail?.should be_false
    thumb = MiniMagick::Image.open(@picture.path)
    thumb.resize "100x100"
    thumb.format "jpg"
    thumb.write @picture.thumbnail
    @picture.has_thumbnail?.should be_true
    @picture.remove_assoc
    @picture.has_thumbnail?.should be_false
  end


end