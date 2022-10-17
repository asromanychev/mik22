class MatchVahMetsAndNormService
  def perform
    unmatched_vah_mets = VahMet.not_matched

    unmatched_vah_mets.each do |met|
      sites_check_sums = met.vah_met_sites.pluck(:check_sum).uniq
      puts "Uniq check_sums for VahMet##{met.id} (#{met.wafer.name}) are #{sites_check_sums}"

      return met.update(sites_check_sums_count_error: true) if sites_check_sums != 1
      match_with_norm(met, sites_check_sums.last)
    end
  end

  private

  def match_with_norm(met, check_sum)
    datetime = met.datetime

    norms = VahNorm.where(check_sum: check_sum)
    if norms.blank?
      puts "Norm for VahMet##{met.id} (#{met.wafer.name} #{met.met_date} #{met.met_time}) not found"
      return
    end

    norms = norms.cover(datetime)

    if norms.blank?
      puts "Norm for VahMet##{met.id} (#{met.wafer.name} #{met.met_date} #{met.met_time}) not found"
      return
    end

    norm = norms.cover(datetime).last
    puts "Norm for VahMet##{met.id} > 1. Takes" if norms.count > 1

    met.update(vah_norm: norm)
  end
end
