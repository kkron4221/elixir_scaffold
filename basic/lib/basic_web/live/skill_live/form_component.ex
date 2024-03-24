defmodule BasicWeb.SkillLive.FormComponent do
  use BasicWeb, :live_component

  alias Basic.SkillUnits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage skill records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="skill-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:position]} type="number" label="Position" />
        <.input field={@form[:trace_id]} type="number" label="Trace" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Skill</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{skill: skill} = assigns, socket) do
    changeset = SkillUnits.change_skill(skill)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"skill" => skill_params}, socket) do
    changeset =
      socket.assigns.skill
      |> SkillUnits.change_skill(skill_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"skill" => skill_params}, socket) do
    save_skill(socket, socket.assigns.action, skill_params)
  end

  defp save_skill(socket, :edit, skill_params) do
    case SkillUnits.update_skill(socket.assigns.skill, skill_params) do
      {:ok, skill} ->
        notify_parent({:saved, skill})

        {:noreply,
         socket
         |> put_flash(:info, "Skill updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_skill(socket, :new, skill_params) do
    case SkillUnits.create_skill(skill_params) do
      {:ok, skill} ->
        notify_parent({:saved, skill})

        {:noreply,
         socket
         |> put_flash(:info, "Skill created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
