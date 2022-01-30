defmodule TimezoneConverter.Repo.Migrations.CreateTimeZones do
  use Ecto.Migration

  def change do
    create table(:time_zones) do
      add :name, :string

      timestamps()
    end
  end
end
