namespace :processing_files do
  desc "Processing files"
  task concat_dat: :environment do
    folder_path = ENV['FOLDER']
    target_file_path = ENV['TARGET']

    if folder_path.nil? || target_file_path.nil?
      puts "ERORR!!!!usage: bundle exec rake processing_files:concat_dat FOLDER=/path/to/files_folder TARGET=/path/to/target_file"
      next
    end
    ConcatDatFiles.new(folder_path, target_file_path).perform
  end
end
