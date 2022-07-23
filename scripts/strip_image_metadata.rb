image_paths = ARGV[0..-1]

threads = image_paths.map do |image_path|
  Thread.new do
    puts "Stripping location information from #{image_path}"
    `mogrify -strip #{image_path}`
    puts "Stripped location information from #{image_path} "
  end
end
threads.each(&:join)
