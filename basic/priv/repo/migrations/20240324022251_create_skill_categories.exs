defmodule Basic.Repo.Migrations.CreateSkillCategories do
  use Ecto.Migration

  def change do
    create table(:skill_categories) do
      add :name, :string
      add :position, :integer
      add :trace_id, :integer
      add :skill_unit_id, references(:skill_units, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:skill_categories, [:skill_unit_id])
  end
end
