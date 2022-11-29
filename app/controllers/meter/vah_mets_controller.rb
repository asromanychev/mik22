class Meter::VahMetsController < MeterController

  before_action :update_search_session, only: :search
  def index
    @vah_mets = VahMet.all
  end

  def reset_search
    reset_search_session
    @vah_mets = []
    render :index
  end

  def search
    # план на 30.11.22
    # 1. Выводить выборку по поиску
    # 2. Выводить значение параметра в выборке
    mets = VahMet.joins(:wafer)
    # use_date_interval from_date to_date
    from_date = DateTime.parse(params[:from_date]).beginning_of_day if params[:from_date].present?
    to_date = DateTime.parse(params[:to_date]).end_of_day if params[:to_date].present?
    from_date ||= DateTime.parse('12-12-2012').beginning_of_day
    to_date ||= DateTime.parse('12-12-2112').end_of_day
    mets = mets.where('datetime BETWEEN ? AND ?', from_date.beginning_of_day, to_date.end_of_day) if params[:use_date_interval].present?
    # product_name
    mets = mets.where('wafers.product = ?', params[:product_name] ) if params[:product_name].present?
    # program_name
    mets = mets.where(norm_name: params[:program_name] ) if params[:program_name].present?
    # parameter_name - тут пока отдельная история
    # lot_packet
    mets = mets.where('wafers.lot_packet IN (?)', params[:lot_packet].reject(&:empty?)) if params[:lot_packet].present?
    # lot_order
    mets = mets.where('wafers.lot_order IN (?)', params[:lot_order].reject(&:empty?)) if params[:lot_order].present?
    # wafer_number
    mets = mets.where('wafers.number IN (?)', params[:wafer_number].reject(&:empty?)) if params[:wafer_number].present?
    @vah_mets = mets
  end

  private

  def search_params
    params
    # params.permit(:vah_met_query, :use_date_interval, :from_date, :to_date,
    #               :product_name, :program_name, :parameter_name,
    #               :lot_packet, :lot_order, :wafer_number)
  end

  def update_search_session
    session[:vah_met_query] = search_params[:vah_met_query]
    session[:use_date_interval] = search_params[:use_date_interval]
    session[:from_date] = search_params[:from_date]
    session[:to_date] = search_params[:to_date]
    session[:product_name] = search_params[:product_name]
    session[:program_name] = search_params[:program_name]
    session[:parameter_name] = search_params[:parameter_name]
    session[:lot_packet] = search_params[:lot_packet]
    session[:lot_order] = search_params[:lot_order]
    session[:wafer_number] = search_params[:wafer_number]
  end

  def reset_search_session
    session[:vah_met_query] = nil
    session[:use_date_interval] = nil
    session[:from_date] = Date.today.at_beginning_of_month.strftime('%Y-%m-%d')
    session[:to_date] = Date.today.strftime('%Y-%m-%d')
    session[:product_name] = nil
    session[:program_name] = nil
    session[:parameter_name] = nil
    session[:lot_packet] = nil
    session[:lot_order] = nil
    session[:wafer_number] = nil
  end
end
