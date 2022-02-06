# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimezoneConverter.Repo.insert!(%TimezoneConverter.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TimezoneConverter.Models.TimeZone, as: TZ
alias TimezoneConverter.Repo

# reset table
Repo.delete_all(TZ)

timezones = Enum.map(Tzdata.zone_list(), &%{name: &1})
{594, _} = Repo.insert_all(TZ, timezones)

if Mix.env() == :test do
  TZ.update_selected("Africa/Accra", true)
  TZ.update_selected("America/Mexico_City", true)
  TZ.update_selected("Europe/Berlin", true)
end
