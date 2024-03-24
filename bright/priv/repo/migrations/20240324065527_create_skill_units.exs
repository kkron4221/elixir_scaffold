defmodule Bright.Repo.Migrations.CreateSkillUnits do
  use Ecto.Migration

  def change do
    create table(:skill_units) do
      add :name, :string
      add :loced_date, :naive_datetime
      add :trace_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
