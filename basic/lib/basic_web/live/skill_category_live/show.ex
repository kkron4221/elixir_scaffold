defmodule BasicWeb.SkillCategoryLive.Show do
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
     |> assign(:skill_category, SkillUnits.get_skill_category!(id))}
  end

  defp page_title(:show), do: "Show Skill category"
  defp page_title(:edit), do: "Edit Skill category"
end
