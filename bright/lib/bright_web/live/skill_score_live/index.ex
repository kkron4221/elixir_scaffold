defmodule BrightWeb.SkillScoreLive.Index do
  use BrightWeb, :live_view

  alias Bright.SkillScores
  alias Bright.SkillScores.SkillScore

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :skill_scores, SkillScores.list_skill_scores())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Skill score")
    |> assign(:skill_score, SkillScores.get_skill_score!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Skill score")
    |> assign(:skill_score, %SkillScore{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Skill scores")
    |> assign(:skill_score, nil)
  end

  @impl true
  def handle_info({BrightWeb.SkillScoreLive.FormComponent, {:saved, skill_score}}, socket) do
    {:noreply, stream_insert(socket, :skill_scores, skill_score)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    skill_score = SkillScores.get_skill_score!(id)
    {:ok, _} = SkillScores.delete_skill_score(skill_score)

    {:noreply, stream_delete(socket, :skill_scores, skill_score)}
  end
end
