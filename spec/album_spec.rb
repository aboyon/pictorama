require_relative 'spec_helper'

describe "For a given folder" do 

  let!(:target_exists_folder) { "#{Dir.pwd}/spec/pictures" }
  let!(:album) { Picturama::Album.new(:folder => target_exists_folder) }

  it "check that Folder module return the list properly" do
    expected_file = "#{target_exists_folder}/king.jpg"
    expect(album.pictures.first).to be_kind_of Picturama::Picture
    expect(album.pictures.first.path).to eq(expected_file)
  end

  it "check thumnails for images" do
    expect(album.pictures.first.has_thumbnail?).to eq false
    expect(album.pictures.first.has_resized?).to eq false
  end

  it "check info for files" do
    expect(album.pictures.first.info).to be_nil
  end

  it "verify how many files are in album" do
    expect(album.pictures).not_to be_empty
  end

  it "gets all the albums in a given folder" do
    expect(
      Picturama::albums(File.dirname(target_exists_folder))
    ).not_to be_empty
  end

  it "verifies the album name is correct based on folder name" do
    album = Picturama::Album.new(:folder => target_exists_folder)
    expect(album.name!).to eq("pictures")
    expect(album.folder).to eq("pictures")
    expect(album.slug).to eq("pictures")
  end

  it "checks the album info from the .info.yml file" do
    expect(album.info['album']['name']).to eq('some pictures here')
  end

end