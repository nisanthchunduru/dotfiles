heic_image_paths = ARGV[0..-1]

threads = heic_image_paths.map do |heic_image_path|
  Thread.new do
    puts "Transforming #{heic_image_path} to jpg"
    jpg_image_path = heic_image_path.sub(/\.(heic|HEIC)/, ".jpg")
    `magick #{heic_image_path} #{jpg_image_path}`
    puts "Transformed #{heic_image_path} to jpg"
  end
end
threads.each(&:join)
