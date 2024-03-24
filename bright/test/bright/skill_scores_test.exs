defmodule Bright.SkillScoresTest do
  use Bright.DataCase

  alias Bright.SkillScores

  describe "skill_scores" do
    alias Bright.SkillScores.SkillScore

    import Bright.SkillScoresFixtures

    @invalid_attrs %{evidence_filled: nil, exam_progress: nil, reference_read: nil, score: nil, skill_id: nil, user_id: nil}

    test "list_skill_scores/0 returns all skill_scores" do
      skill_score = skill_score_fixture()
      assert SkillScores.list_skill_scores() == [skill_score]
    end

    test "get_skill_score!/1 returns the skill_score with given id" do
      skill_score = skill_score_fixture()
      assert SkillScores.get_skill_score!(skill_score.id) == skill_score
    end

    test "create_skill_score/1 with valid data creates a skill_score" do
      valid_attrs = %{evidence_filled: true, exam_progress: "some exam_progress", reference_read: true, score: "some score", skill_id: 42, user_id: 42}

      assert {:ok, %SkillScore{} = skill_score} = SkillScores.create_skill_score(valid_attrs)
      assert skill_score.evidence_filled == true
      assert skill_score.exam_progress == "some exam_progress"
      assert skill_score.reference_read == true
      assert skill_score.score == "some score"
      assert skill_score.skill_id == 42
      assert skill_score.user_id == 42
    end

    test "create_skill_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SkillScores.create_skill_score(@invalid_attrs)
    end

    test "update_skill_score/2 with valid data updates the skill_score" do
      skill_score = skill_score_fixture()
      update_attrs = %{evidence_filled: false, exam_progress: "some updated exam_progress", reference_read: false, score: "some updated score", skill_id: 43, user_id: 43}

      assert {:ok, %SkillScore{} = skill_score} = SkillScores.update_skill_score(skill_score, update_attrs)
      assert skill_score.evidence_filled == false
      assert skill_score.exam_progress == "some updated exam_progress"
      assert skill_score.reference_read == false
      assert skill_score.score == "some updated score"
      assert skill_score.skill_id == 43
      assert skill_score.user_id == 43
    end

    test "update_skill_score/2 with invalid data returns error changeset" do
      skill_score = skill_score_fixture()
      assert {:error, %Ecto.Changeset{}} = SkillScores.update_skill_score(skill_score, @invalid_attrs)
      assert skill_score == SkillScores.get_skill_score!(skill_score.id)
    end

    test "delete_skill_score/1 deletes the skill_score" do
      skill_score = skill_score_fixture()
      assert {:ok, %SkillScore{}} = SkillScores.delete_skill_score(skill_score)
      assert_raise Ecto.NoResultsError, fn -> SkillScores.get_skill_score!(skill_score.id) end
    end

    test "change_skill_score/1 returns a skill_score changeset" do
      skill_score = skill_score_fixture()
      assert %Ecto.Changeset{} = SkillScores.change_skill_score(skill_score)
    end
  end
end
