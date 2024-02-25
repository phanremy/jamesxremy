module ItemsHelper
  def unit_name(unit)
    t("items.unit.#{unit}")
  end

  def units_list(space, item)
    list = Item::UNITS.map { |unit| [unit_name(unit), unit] } +
           space.extra_units.map { |unit| [unit, unit] }
    options_for_select(list, item.unit)
  end
end
