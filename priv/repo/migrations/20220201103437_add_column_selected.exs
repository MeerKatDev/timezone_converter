defmodule TimezoneConverter.Repo.Migrations.AddColumnSelected do
  use Ecto.Migration

  def change do
    alter table(:time_zones) do
      add :selected, :boolean
    end
  end
end
