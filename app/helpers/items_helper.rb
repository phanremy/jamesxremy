module ItemsHelper
  def units_list(space, item)
    list = Item::UNITS.map { |unit| [t("items.unit.#{unit}"), unit] } +
           space.extra_units.map { |unit| [unit, unit] }
    options_for_select(list, item.unit)
  end
end
