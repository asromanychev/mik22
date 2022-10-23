module VahHelper

  def test_help
    'Test help'
  end

  def options_for_wafer_name(mets)
    price_kinds_for_select = options_for_select(price_kinds(account, true))
  end
end
