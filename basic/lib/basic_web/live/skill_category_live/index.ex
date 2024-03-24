defmodule BasicWeb.SkillCategoryLive.Index do
  use BasicWeb, :live_view

  alias Basic.SkillUnits
  alias Basic.SkillUnits.SkillCategory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :skill_categories, SkillUnits.list_skill_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Skill category")
    |> assign(:skill_category, SkillUnits.get_skill_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Skill category")
    |> assign(:skill_category, %SkillCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Skill categories")
    |> assign(:skill_category, nil)
  end

  @impl true
  def handle_info({BasicWeb.SkillCategoryLive.FormComponent, {:saved, skill_category}}, socket) do
    {:noreply, stream_insert(socket, :skill_categories, skill_category)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    skill_category = SkillUnits.get_skill_category!(id)
    {:ok, _} = SkillUnits.delete_skill_category(skill_category)

    {:noreply, stream_delete(socket, :skill_categories, skill_category)}
  end
end
