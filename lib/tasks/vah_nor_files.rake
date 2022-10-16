namespace :vah_nor_files do
  desc "Upload Nor files"
  task upload: :environment do
    folder_path = ENV['TARGET']

    if folder_path.nil?
      puts "ERORR!!!!usage: bundle exec rake vah_nor_files:upload TARGET=/path/to/files_folder которые содержат nor-файлы"
      next
    end

    Dir.glob("#{folder_path}/**/*.*") do |file_path|
      UploadVahDatFileService.new(file_path).perform
    end
  end

  desc "Sync source from Vah-server to Miklab-server"
  task sync_files: :environment do

  end
end
