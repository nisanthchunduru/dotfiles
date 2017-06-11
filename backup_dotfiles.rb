class DotfileInfo
  def initialize(dotfile_info_string)
  	@dotfile_info_string = dotfile_info_string
  end

  def path
  	@dotfile_info_string.split(":")[0]
  end

  def backup_path
  	@dotfile_info_string.split(":")[1]
  end
end

dotfile_info_strings = `lsrc`.split("\n")
dotfile_info_strings.each do |dotfile_info_string|
  dotfile_info = DotfileInfo.new(dotfile_info_string)
  FileUtils.cp(dotfile_info.path, dotfile_info.backup_path) if File.exist?(dotfile_info.path)
end