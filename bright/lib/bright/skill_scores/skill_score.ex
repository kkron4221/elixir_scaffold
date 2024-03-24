defmodule Bright.SkillScores.SkillScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skill_scores" do
    field :evidence_filled, :boolean, default: false
    field :exam_progress, :string
    field :reference_read, :boolean, default: false
    field :score, :string
    field :skill_id, :integer
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(skill_score, attrs) do
    skill_score
    |> cast(attrs, [:user_id, :skill_id, :score, :exam_progress, :reference_read, :evidence_filled])
    |> validate_required([:user_id, :skill_id, :score, :exam_progress, :reference_read, :evidence_filled])
  end
end
