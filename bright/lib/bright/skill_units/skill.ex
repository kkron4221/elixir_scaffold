defmodule Bright.SkillUnits.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skills" do
    field :name, :string
    field :position, :integer
    field :trace_id, :integer
    field :skill_category_id, :id

    has_many :skill_scores, Bright.SkillScores.SkillScore

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:name, :position, :trace_id])
    |> validate_required([:name, :position, :trace_id])
  end
end
