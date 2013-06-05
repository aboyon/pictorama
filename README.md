# Pictorama

[![Code Climate](https://codeclimate.com/github/aboyon/pictorama.png)](https://codeclimate.com/github/aboyon/pictorama)

Welcome to *Pictorama*. An easy picture gallery based on directory and files

### How to install

Just clone the github repo..

```ruby
git clone git@github.com:aboyon/pictorama.git
```
### Configure your settings...

Copy the config.sample.yml to config.yml (into the config/ file)

```ruby
cd config/
cp config.sample.yml config.yml
```
and then proceed to adjust the settings

```yaml
picturama:
  album_source: '/home/user/Pictures/some_folder/'
  allowed_formats: ['jpg','png','jpeg']
  thumbnail_prefix: thumb_
  thumnail_default_size: "200x200"
```

generate your thumbnails quickly, by using the rake task created for that
```
rake thumbnail:generate["/some/folder"] #you can specify a different folder...
```
and then you'll get an answer like this:
```
Generating 30 thumbnails for folder /some/folder/ ...
Size: 200x200
Thumbnail generated for source 1.JPG. Target destination thumb_1.JPG
Thumbnail generated for source 2.JPG. Target destination thumb_2.JPG
```
# License

Please [see licence file](https://github.com/aboyon/pictorama/blob/master/LICENCE) for further reading.
