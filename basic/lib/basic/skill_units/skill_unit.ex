defmodule Basic.SkillUnits.SkillUnit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skill_units" do
    field :loced_date, :naive_datetime
    field :name, :string
    field :trace_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(skill_unit, attrs) do
    skill_unit
    |> cast(attrs, [:name, :loced_date, :trace_id])
    |> validate_required([:name, :loced_date, :trace_id])
  end
end
