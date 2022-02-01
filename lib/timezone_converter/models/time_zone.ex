defmodule TimezoneConverter.Models.TimeZone do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset
  alias TimezoneConverter.Repo

  schema "time_zones" do
    field :name, :string
    field :selected, :boolean, default: false
  end

  @doc false
  def changeset(time_zone, attrs) do
    time_zone
    |> cast(attrs, [:name, :boolean])
    |> validate_required([:name])
  end

  def all(), do: Repo.all(__MODULE__)
  def all_selected(), do: Repo.all(from tz in __MODULE__, where: tz.selected)

  def update_selected(name, select?) do
    Repo.get_by(__MODULE__, name: name)
    |> change(%{selected: select?})
    |> Repo.update()
  end
end
