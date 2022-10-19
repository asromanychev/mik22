class ConcatDatFiles
  attr_reader :folder_path, :target_file_path

  def initialize(folder_path, target_file_path)
    @folder_path = folder_path
    @target_file_path = target_file_path
  end

  def perform
    # match_line_pattern = UploadVahDatFileService::MIKAIK_MEASURING_REGEXP
    Dir.glob("#{folder_path}/**/*.[Dd][Aa][Tt]") do |file_path|
      concat_lines(file_path)
    end
  end

  def concat_lines(file_path)
    puts "Open #{file_path}"

    file = File.open(file_path)
    target_file = File.open(target_file_path, 'a+')

    file.each do |line|
      next if target_file.each_line.any? { |target_line| target_line.chomp == line.chomp }
      target_file.write(line)
    end
    target_file.close
  end
end
