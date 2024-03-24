defmodule BrightWeb.SkillLive.Show do
  use BrightWeb, :live_view

  alias Bright.SkillUnits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:skill, SkillUnits.get_skill!(id))}
  end

  defp page_title(:show), do: "Show Skill"
  defp page_title(:edit), do: "Edit Skill"
end
