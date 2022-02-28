json.array! @players do |player|
  json.id player.id
  json.first_name player.first_name
  json.last_name player.last_name
  json.birthdate player.pretty_birthdate
  json.years_old player.years_old
  json.gender player.gender
end