class Meter::VahMetsController < MeterController
  def index
    @vah_mets = VahMet.all
  end
end
