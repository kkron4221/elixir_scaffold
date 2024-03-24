defmodule BrightWeb.SkillScoreLiveTest do
  use BrightWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bright.SkillScoresFixtures

  @create_attrs %{evidence_filled: true, exam_progress: "some exam_progress", reference_read: true, score: "some score", skill_id: 42, user_id: 42}
  @update_attrs %{evidence_filled: false, exam_progress: "some updated exam_progress", reference_read: false, score: "some updated score", skill_id: 43, user_id: 43}
  @invalid_attrs %{evidence_filled: false, exam_progress: nil, reference_read: false, score: nil, skill_id: nil, user_id: nil}

  defp create_skill_score(_) do
    skill_score = skill_score_fixture()
    %{skill_score: skill_score}
  end

  describe "Index" do
    setup [:create_skill_score]

    test "lists all skill_scores", %{conn: conn, skill_score: skill_score} do
      {:ok, _index_live, html} = live(conn, ~p"/skill_scores")

      assert html =~ "Listing Skill scores"
      assert html =~ skill_score.exam_progress
    end

    test "saves new skill_score", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_scores")

      assert index_live |> element("a", "New Skill score") |> render_click() =~
               "New Skill score"

      assert_patch(index_live, ~p"/skill_scores/new")

      assert index_live
             |> form("#skill_score-form", skill_score: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#skill_score-form", skill_score: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/skill_scores")

      html = render(index_live)
      assert html =~ "Skill score created successfully"
      assert html =~ "some exam_progress"
    end

    test "updates skill_score in listing", %{conn: conn, skill_score: skill_score} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_scores")

      assert index_live |> element("#skill_scores-#{skill_score.id} a", "Edit") |> render_click() =~
               "Edit Skill score"

      assert_patch(index_live, ~p"/skill_scores/#{skill_score}/edit")

      assert index_live
             |> form("#skill_score-form", skill_score: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#skill_score-form", skill_score: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/skill_scores")

      html = render(index_live)
      assert html =~ "Skill score updated successfully"
      assert html =~ "some updated exam_progress"
    end

    test "deletes skill_score in listing", %{conn: conn, skill_score: skill_score} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_scores")

      assert index_live |> element("#skill_scores-#{skill_score.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#skill_scores-#{skill_score.id}")
    end
  end

  describe "Show" do
    setup [:create_skill_score]

    test "displays skill_score", %{conn: conn, skill_score: skill_score} do
      {:ok, _show_live, html} = live(conn, ~p"/skill_scores/#{skill_score}")

      assert html =~ "Show Skill score"
      assert html =~ skill_score.exam_progress
    end

    test "updates skill_score within modal", %{conn: conn, skill_score: skill_score} do
      {:ok, show_live, _html} = live(conn, ~p"/skill_scores/#{skill_score}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Skill score"

      assert_patch(show_live, ~p"/skill_scores/#{skill_score}/show/edit")

      assert show_live
             |> form("#skill_score-form", skill_score: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#skill_score-form", skill_score: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/skill_scores/#{skill_score}")

      html = render(show_live)
      assert html =~ "Skill score updated successfully"
      assert html =~ "some updated exam_progress"
    end
  end
end
