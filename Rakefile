desc "Build and run all available programs in the languages/* directory"
task :run do
  puts "Building all languages ..."
  Dir["languages/*/Rakefile"].sort.each do |path_to_rakefile|
    base_path, language, _ = path_to_rakefile.split('/')

    language_path = "#{base_path}/#{language}"
    puts "  * Entering directory '#{language_path}'"

    load path_to_rakefile

    begin
      clean_task_name = "#{language}:clean"
      print "    * Running task '#{clean_task_name}'... "

      clean_task = Rake::application.tasks.detect {|t| t.name == clean_task_name }

      if clean_task
        clean_task.invoke
        puts "done."
      else
        puts "not found."
      end

      build_task_name = "#{language}:build"
      print "    * Running task '#{build_task_name}'... "
      Rake::Task[build_task_name].invoke
      puts "done."

      ruby_exec = `which ruby`.chomp

      print "    * Running tests..."
      test_output = `PATH="./#{language_path}" "#{ruby_exec}" ./test/otp_test.rb`
      if $?.success?
        puts "done."
      else
        puts "failed."
        puts test_output
      end
    rescue => e
      puts "failed."
      puts "      #{e.message}"
    end

  end
end

task :default => :run