photos_paths = ARGV[0..-1]

threads = photos_paths.map do |photo_path|
  Thread.new do
    puts "Stripping location information from #{photo_path}"
    `mogrify -strip #{photo_path}`
    puts "Stripped location information from #{photo_path}"
  end
end
threads.each(&:join)
