require 'mini_magick'
require_relative 'spec_helper'

describe "For a given picture in a given album" do 
  
  before :each do
    @target_exists_folder = "#{Dir.pwd}/spec/pictures"
    album = Picturama::Album.new(:folder => @target_exists_folder)
    album.init_thumbnails
    @picture = album.pictures.first
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

  it "checks the image basename" do
    @picture.basename.should == 'king.jpg'
  end


end