namespace :picturama do
  namespace :album do
    desc "metadata handling for a given album"
    namespace :metadata do
      desc "generate metadata for an album in a given path"
      task :generate do
        puts ""
        print "Type the album path:   "
        path = STDIN.gets.chomp
        if File.directory?(path)
          puts "Title:"
          title = STDIN.gets.chomp
          unless title.nil?
            puts "Description (optional):"
            description = STDIN.gets.chomp
            puts "Author (optional):"
            author = STDIN.gets.chomp
            info = {"album" => {"title" => title, "description" => description, "author" => author}}
            File.open("#{path}/.info.yml", 'w+') {|f| f.write(info.to_yaml) }
          else
            puts "Title cannot be empty. Run the task again"  
          end
        else
          puts "Sorry but #{path.inspect} entered is not a folder. Run the task again"
        end
      end

      desc "retrieve metadata album based on path"
      task :check do
        puts ""
        print "Type the album path:   "
        path = STDIN.gets.chomp
        info_file = "#{path}/.info.yml"
        if File.directory?(path) && File.exists?(info_file)
          data = YAML.load_file(info_file)['album']
          puts "Title: #{data['title']}"
          puts "Description: #{data['description']}"
          puts "Author: #{data['author']}"
        else
          puts "Sorry but #{path.inspect} entered is not a folder. Run the task again"
        end
      end
    end
  end
end