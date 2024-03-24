defmodule Basic.Repo.Migrations.CreateSkills do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :string
      add :position, :integer
      add :trace_id, :integer
      add :skill_category_id, references(:skill_categories, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:skills, [:skill_category_id])
  end
end
