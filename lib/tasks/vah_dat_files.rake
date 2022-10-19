namespace :vah_dat_files do
  desc "Upload Dat files"
  task upload: :environment do
    folder_path = ENV['TARGET']

    if folder_path.nil?
      puts "ERORR!!!!usage: bundle exec rake vah_dat_files:upload TARGET=/path/to/files_folder которые содержат dat-файлы"
      next
    end

    Dir.glob("#{folder_path}/**/*.[Dd][Aa][Tt]") do |file_path|
      UploadVahDatFileService.new(file_path).perform
      MatchVahMetsAndNormService.new.perform
    end
  end

  desc "Sync source from Vah-server to Miklab-server"
  task sync_files: :environment do

  end
end
