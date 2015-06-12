require 'mini_magick'
require_relative 'spec_helper'

describe "For a given picture in a given album" do 

  let!(:target_exists_folder) { "#{Dir.pwd}/spec/pictures" }
  let!(:album) { Picturama::Album.new(:folder => target_exists_folder) }
  let!(:thumb_w) { 100 }
  let!(:picture) { album.pictures.first }

  before { album.init_thumbnails }

  it "generate thumbnail" do
    expect(picture.has_thumbnail?).to be_false
    thumb = MiniMagick::Image.open(picture.path)
    thumb.resize "100x100"
    thumb.format "jpg"
    thumb.write picture.thumbnail
    expect(picture.has_thumbnail?).to be_true
    picture.remove_assoc
    expect(picture.has_thumbnail?).to be_false
  end

  it "checks the image basename" do
    expect(picture.basename).to eq 'king.jpg'
  end

  it "checks the image extension" do
    expect(picture.type.downcase).to eq 'jpg'
  end


end