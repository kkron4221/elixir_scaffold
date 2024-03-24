defmodule BrightWeb.SkillLive.Index do
  use BrightWeb, :live_view

  alias Bright.SkillUnits
  alias Bright.SkillUnits.Skill

  @impl true
  def mount(_params, _session, socket) do
  #  {:ok, stream(socket, :skills, SkillUnits.list_skills())}
    {:ok, stream(socket, :skills, SkillUnits.list_skills_with_scores(_params["id"]))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Skill")
    |> assign(:skill, SkillUnits.get_skill!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Skill")
    |> assign(:skill, %Skill{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Skills")
    |> assign(:skill, nil)
  end

  @impl true
  def handle_info({BrightWeb.SkillLive.FormComponent, {:saved, skill}}, socket) do
    {:noreply, stream_insert(socket, :skills, skill)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    skill = SkillUnits.get_skill!(id)
    {:ok, _} = SkillUnits.delete_skill(skill)

    {:noreply, stream_delete(socket, :skills, skill)}
  end
end
