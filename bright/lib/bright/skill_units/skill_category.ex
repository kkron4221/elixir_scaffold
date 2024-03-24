defmodule Bright.SkillUnits.SkillCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skill_categories" do
    field :name, :string
    field :position, :integer
    field :trace_id, :integer
    field :skill_unit_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(skill_category, attrs) do
    skill_category
    |> cast(attrs, [:name, :position, :trace_id])
    |> validate_required([:name, :position, :trace_id])
  end
end
