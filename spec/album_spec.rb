require_relative 'spec_helper'

describe "For a given folder" do 
  
  before :each do
    @target_exists_folder = "#{Dir.pwd}/spec/pictures"
    @album = Picturama::Album.new(:folder => @target_exists_folder)
  end

  it "check that Folder module return the list properly" do
    expected_file = "#{@target_exists_folder}/king.jpg"
    @album.pictures.first.class.should == Picturama::Picture.new('.').class
    @album.pictures.first.path.should == expected_file
  end

  it "check thumnails for images" do
    @album.pictures.first.has_thumbnail?.should be_false
    @album.pictures.first.has_resized?.should be_false
  end

  it "check info for files" do
    @album.pictures.first.info.nil?.should be_true
  end

  it "verify how many files are in album" do
    @album.count_pictures.should > 0
  end

  it "gets all the albums in a given folder" do
    Picturama::albums(File.dirname(@target_exists_folder)).size.should > 0
  end


end