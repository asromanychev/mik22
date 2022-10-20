class UploadVahDatFileService
  # 220514 - http://rubular.com/r/rvKdwxDntR
  VAHTA_MEASURING_REGEXP = %r{
      ^(\d){1,2}[,]
      (\d{2}.\d{2}.\d{2})[,]
      ([\w\d]*)[,]
      ([\s\d][\s\d]\d)
      .{3}
      ([\s\d]{0,3}\d)[,]
      (\d{1,})[,]
      (\d+)[,]
      (\d\d:\d\d)[,]
      (\w+)[,]
      ([\w\d]*)[,]
      (.+)
    }x
  # 11042016 - http://rubular.com/r/ohpZvCxKGS
  #  упростил, сделал одинаковые блоки ([\s\w\d]*) почти для всех частей
  MIKAIK_MEASURING_REGEXP = %r{^([\s\w\d]*)[,](\d{2}.\d{2}.\d{2})[,]([\s\w\d]*)[,]([\s\w\d]*)[,]([\s\w\d]*)[,]([\s\w\d]*)[,]([\s\w\d]*)[,]([\s\w\d]*)[,](\d\d:\d\d)[,]([\s\w\d]*)[,]([\s\w\d]*)[,](.+)}

  attr_reader :path, :vah_import_dat

  def initialize(path)
    @path = path
    @vah_import_dat = VahImport::Dat.find_by(path: path) || VahImport::Dat.create!(path: path, started_at: Time.now)
    @line_count = 0
  end

  def perform
    puts "Start new Import from #{path} VahImport::Dat with id = #{vah_import_dat.id}"
    file = File.open(path)
    #  1. проверить что файл валидный
    #  2. собрать все ошибки
    #  3. проверить чтобы не было дубля. отметить что VahMetSite = дубль (хоть и файл другой). указать id
    return unless file.present?

    file.each do |line|
      upload_line(line.chomp)
    end
    vah_import_dat.update(ended_at: Time.now)
    vah_import_dat.update(successed: true) unless vah_import_dat.import_errors
  end

  def pattern
    # вахту оставил на всякий случай. но всегду у нас Микаик
    MIKAIK_MEASURING_REGEXP
  end

  def upload_line(line)
    @line_count += 1
    match_pattern = (line.include?('VAHTA') ? VAHTA_MEASURING_REGEXP : MIKAIK_MEASURING_REGEXP)
    matched = match_pattern.match(line)

    if matched.nil?
      VahImportDatLineError.find_or_create_by(vah_import_dat: vah_import_dat, line_number: @line_count, line: line)
      puts "[#{@line_count}] Error line '#{line}'"
      return
    end

    frag_number = matched[1] # 1.	1
    met_date = matched[2] # 2.	04.04.16
    product_name = matched[3] # 3.	KM519
    lot = matched[4] # 4.	44
    device = matched[5] # 5.	m4
    wafer_number = matched[6] # 6.	19
    site_number = matched[7] # 7.	1
    operator = matched[8] # 8.	32261
    met_time = matched[9] # 9.	09:42
    _device_name = matched[10] # 10. M_IAK
    norm_name = matched[11] # 11.	KM354
    met_line = matched[12].chomp  # 12.	107.9482,6.9215,18.5502,31.9302,25.2399,22.9831,31.5961,116.3564,233.9124,2.5314,6.9238,18.2342,32.1405,25.2636,23.1229,31.8232,327.4253,-21.5093,-30.8313,-29.3267,217.0175,

    wafer = Wafer.find_or_create_by(product: product_name, lot: lot, number: wafer_number)
    met = VahMet.find_or_create_by(wafer: wafer, met_date: met_date, met_time: met_time, norm_name: norm_name, device: device, operator: operator)
    # мы можем как то узнать, что VahMet полностью собралось. что все site записаны и пометить флагом complite ?
    # измерения надо найти из какого
    site = VahMetSite.find_or_create_by(vah_met: met, site_number: site_number, vah_import_dat: vah_import_dat)

    if site.frags_values[frag_number].present?
      puts "[#{@line_count}] Already in VahMetSite##{site.id} '#{line}'"
      # puts "Line in VahMetSite => #{site.frags_values[frag_number]}"
      return
    end
    site.frags_values[frag_number] = met_line.split(',').compact
    site.line_numbers << @line_count

    site.save
    puts "[#{@line_count}] Success line. Wafer##{wafer.id } #{wafer.name}, met time: #{met.met_date} #{met.met_time}"
  end
end

# TODO:
# есть идея собирать все строки в разные файлы, сгруппиров по пластинам и программам.
# после того как файл исхоник был обработан. мы добавляем неповтоярбщиеся строки в файл с программой.
# прописывать бы еще номер строки и файл от куда он был