module Meter::VahMetsHelper
  # пока не используется
  def collapse_if_session(field_id)
    '' if session[field_id]
    'collapse'
  end

  def link_to_reset_search
    link_to t('.reset_search'),
            meter_vah_mets_reset_search_path,
            remote: true, class: "btn btn-default"
  end
end
