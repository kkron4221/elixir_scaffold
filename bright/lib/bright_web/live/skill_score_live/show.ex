defmodule BrightWeb.SkillScoreLive.Show do
  use BrightWeb, :live_view

  alias Bright.SkillScores

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:skill_score, SkillScores.get_skill_score!(id))}
  end

  defp page_title(:show), do: "Show Skill score"
  defp page_title(:edit), do: "Edit Skill score"
end
