defmodule Basic.SkillScoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Basic.SkillScores` context.
  """

  @doc """
  Generate a skill_score.
  """
  def skill_score_fixture(attrs \\ %{}) do
    {:ok, skill_score} =
      attrs
      |> Enum.into(%{
        evidence_filled: true,
        exam_progress: "some exam_progress",
        reference_read: true,
        score: "some score",
        skill_id: 42,
        user_id: 42
      })
      |> Basic.SkillScores.create_skill_score()

    skill_score
  end
end
