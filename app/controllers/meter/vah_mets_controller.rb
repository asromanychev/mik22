class Meter::VahMetsController < MeterController

  before_action :update_search_session, only: :search
  def index
    @vah_mets = VahMet.all
  end

  def search
    # план на 12.11.22
    # 1. генерировать запрос по params
    # 2. если session есть то значит показывать поля поиска
    # 3. сделать кнопку сброса сессии
    # 4. научится сохранять выбранные даты календаря в сессии
    @vah_mets = VahMet.last(5)
  end

  private

  def search_params
    params
    # params.permit(:vah_met_query, :use_date_interval, :from_date, :to_date,
    #               :product_name, :program_name, :parameter_name,
    #               :lot_packet, :lot_order, :wafer_number)
  end

  def update_search_session
    # binding.pry
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
    session[:vah_met_query] = ''
    session[:use_date_interval] = ''
    session[:from_date] = ''
    session[:to_date] = ''
    session[:product_name] = ''
    session[:program_name] = ''
    session[:parameter_name] = ''
    session[:lot_packet] = ''
    session[:lot_order] = ''
    session[:wafer_number] = ''
  end
end
