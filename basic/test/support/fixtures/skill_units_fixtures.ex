defmodule Basic.SkillUnitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Basic.SkillUnits` context.
  """

  @doc """
  Generate a skill_unit.
  """
  def skill_unit_fixture(attrs \\ %{}) do
    {:ok, skill_unit} =
      attrs
      |> Enum.into(%{
        loced_date: ~N[2024-03-23 02:22:00],
        name: "some name",
        trace_id: 42
      })
      |> Basic.SkillUnits.create_skill_unit()

    skill_unit
  end

  @doc """
  Generate a skill_category.
  """
  def skill_category_fixture(attrs \\ %{}) do
    {:ok, skill_category} =
      attrs
      |> Enum.into(%{
        name: "some name",
        position: 42,
        trace_id: 42
      })
      |> Basic.SkillUnits.create_skill_category()

    skill_category
  end

  @doc """
  Generate a skill.
  """
  def skill_fixture(attrs \\ %{}) do
    {:ok, skill} =
      attrs
      |> Enum.into(%{
        name: "some name",
        position: 42,
        trace_id: 42
      })
      |> Basic.SkillUnits.create_skill()

    skill
  end
end
