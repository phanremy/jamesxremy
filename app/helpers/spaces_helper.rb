module SpacesHelper
  def software_name(software)
    t("spaces.softwares.#{software}")
  end

  def softwares_list
    Space::SOFTWARES.map { |software| [software_name(software), software] }
  end
end
