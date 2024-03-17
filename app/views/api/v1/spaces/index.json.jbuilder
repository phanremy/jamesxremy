json.array! @spaces do |space|
  json.extract! space, :id, :description, :software
end
