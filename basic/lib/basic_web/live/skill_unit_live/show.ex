defmodule BasicWeb.SkillUnitLive.Show do
  use BasicWeb, :live_view

  alias Basic.SkillUnits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:skill_unit, SkillUnits.get_skill_unit!(id))}
  end

  defp page_title(:show), do: "Show Skill unit"
  defp page_title(:edit), do: "Edit Skill unit"
end
