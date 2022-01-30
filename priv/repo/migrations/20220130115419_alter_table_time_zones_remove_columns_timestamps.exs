defmodule TimezoneConverter.Repo.Migrations.AlterTableTimeZonesRemoveColumnsTimestamps do
  use Ecto.Migration

  def change do
    alter table(:time_zones) do
      remove :inserted_at
      remove :updated_at
    end
  end
end
