defmodule Basic.Repo.Migrations.CreateSkillScores do
  use Ecto.Migration

  def change do
    create table(:skill_scores) do
      add :user_id, :integer
      add :skill_id, :integer
      add :score, :string
      add :exam_progress, :string
      add :reference_read, :boolean, default: false, null: false
      add :evidence_filled, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
