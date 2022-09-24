class MeterController < ActionController::Base
  layout 'meter'
  before_action :set_breadcrumb

  private

  def set_breadcrumb
    @page_title = "#{controller_name.humanize} #{action_name.humanize}"
    breadcrumb "Home", :meter_root_path
    breadcrumb controller_name.humanize, ""
    breadcrumb action_name.humanize, request.original_fullpath
  end
end
