class UploadVahNorFileService
  W_PROGRAM = /^w_program=(\w+)[;].*$/
  W_NUMTQ = /^w_numtq=(\d+)[;].*$/
  W_NUMFR = /^w_numfr=(\d+)[;].*$/
  W_PARAMS_COUNT = /^w_param_count=(\d+)[;].*$/
  #http://rubular.com/r/N2tjRwhybM
  NOR_LINE = /^([\^\s]{0,1})([\w\d\/\.\(\)*\+\_\-\%\s\(\)]*)\s*[,]\s*([\%\w\/\d+\\]*)\s*[,]\s*(\d+)\s*[,]\s*([\d\.\-\+]*)\s*[,]\s*([\d\.\-\+]*)\s*[,]\s*(\d+)[;].*$/
  PROGRAM_NAME =  /(\w+[^s])s?.nor$/i
  NOR_NAME = /(\w+[^s])s?/i

  attr_reader :path, :vah_import_nor, :vah_norm

  def initialize(path)
    @path = path
    @vah_import_nor = VahImport::Nor.find_by(path: path) || VahImport::Nor.create!(path: path, started_at: Time.now)
    @line_count = 0
    @param_count = 0
  end

  def perform
    puts "Start new Import from #{path} VahImport::Nor with id = #{vah_import_nor.id}"
    file = File.open(path)
    #  1. проверить что файл валидный
    #  2. собрать все ошибки
    #  3. проверить чтобы не было дубля. отметить что VahMetSite = дубль (хоть и файл другой). указать id
    return unless file.present?

    #по названию пути /home/anri/Загрузки/test_mik22/norm/2022-07-14/16_31_04 вытаскиваем его start_time
    @start_time = DateTime.parse(File.dirname(path).split('/').last(2).to_s.gsub('_', ':'))
    return unless @start_time

    file.each do |line|
      @line_count += 1
      init_vah_norm(line.chomp) if @line_count < 5
      check_vah_norm if @line_count == 5
      upload_line(line.chomp) if @line_count >= 5 && @vah_norm_checked
    end
    vah_import_nor.update(ended_at: Time.now)
    vah_import_nor.update(successed: true) unless vah_import_nor.import_errors
  end

  private

  def init_vah_norm(line)
    name = match_w_program(line)[1].upcase if @line_count == 1 && match_w_program(line)
    @vah_norm = VahNorm.find_or_create_by!(name: name, is_nors: false, start_time: @start_time) if name

    sites_count = match_w_numtq(line)[1].upcase if @line_count == 2 && match_w_numtq(line)
    @vah_norm.update(sites_count: sites_count) if sites_count

    frags_count = match_w_numfr(line)[1].upcase if @line_count == 3 && match_w_numfr(line)
    @vah_norm.update(frags_count: frags_count) if frags_count

    params_count = match_w_params_count(line)[1].upcase if @line_count == 4 && match_w_params_count(line)
    @vah_norm.update(params_count: params_count) if params_count

    puts "[INIT VahNorm##{@vah_norm.id}] Success #{@vah_norm.name} tq=#{@vah_norm.sites_count} fr=#{@vah_norm.frags_count} params=#{@vah_norm.params_count}" if @line_count == 4
  end

  def check_vah_norm
    return @vah_norm_checked if @vah_norm_checked
    #  тут нужна проверка что инициализация VahNor прошла успешна = файл норм ок
    @vah_norm_checked = true
  end

  def upload_line(line)
    matched = regexp_for_nor_lines.match(line)
    if matched
      @param_count += 1
      is_rej = (matched[1] == "^" ? true : false)
      name = matched[2].strip
      unit = (matched[3].nil? ? "" : matched[3])
      frag = matched[4].strip
      limit_low = matched[5].strip
      limit_high = matched[6].strip
      persent = matched[7].strip
      norm_param = [is_rej, name, unit, frag, limit_low, limit_high, persent]

      vah_norm.frags_params[frag] ||= []
      # проверить что такая строка уже не занесена
      return if vah_norm.frags_params[frag].include?(norm_param)

      vah_norm.frags_params[frag] << norm_param
      vah_norm.save
      puts "[param ##{@param_count}] Success"
    end
  rescue => e
    # создаем ошибку о дубле. Записываем куда-то чтобы потом можно было посмотреть и сравнить два эти файла.
  end

  # 1-ая строчка - проверка на соответсвие название программы и в строке
  def match_w_program(line)
    (W_PROGRAM).match(line)
  end

  def match_w_numtq line
    (W_NUMTQ).match(line)
  end

  def match_w_numfr line
    (W_NUMFR).match(line)
  end

  def match_w_params_count line
    (W_PARAMS_COUNT).match(line)
  end

  def match_program_name (line)
    (PROGRAM_NAME).match(line)
  end

  def regexp_for_nor_lines
    NOR_LINE
  end
end
