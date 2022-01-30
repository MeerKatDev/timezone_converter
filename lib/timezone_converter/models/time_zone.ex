defmodule TimezoneConverter.Models.TimeZone do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimezoneConverter.Repo

  schema "time_zones" do
    field :name, :string
  end

  @doc false
  def changeset(time_zone, attrs) do
    time_zone
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def all(), do: Repo.all(__MODULE__)
end
