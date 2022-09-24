class Meter::DashboardController < MeterController
  def show
    _breadcrumbs.delete_at(_breadcrumbs.length - 1)
    @page_title = "Dashboard"
  end
end
