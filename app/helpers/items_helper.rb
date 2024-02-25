module ItemsHelper
  def unit_name(unit)
    t("items.unit.#{unit}")
  end

  def units_list(space)
    Item::UNITS.map { |unit| [unit_name(unit), unit] } +
      space.extra_units.map { |unit| [unit, unit] }
  end
end
