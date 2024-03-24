defmodule BasicWeb.SkillUnitLive.FormComponent do
  use BasicWeb, :live_component

  alias Basic.SkillUnits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage skill_unit records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="skill_unit-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:loced_date]} type="datetime-local" label="Loced date" />
        <.input field={@form[:trace_id]} type="number" label="Trace" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Skill unit</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{skill_unit: skill_unit} = assigns, socket) do
    changeset = SkillUnits.change_skill_unit(skill_unit)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"skill_unit" => skill_unit_params}, socket) do
    changeset =
      socket.assigns.skill_unit
      |> SkillUnits.change_skill_unit(skill_unit_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"skill_unit" => skill_unit_params}, socket) do
    save_skill_unit(socket, socket.assigns.action, skill_unit_params)
  end

  defp save_skill_unit(socket, :edit, skill_unit_params) do
    case SkillUnits.update_skill_unit(socket.assigns.skill_unit, skill_unit_params) do
      {:ok, skill_unit} ->
        notify_parent({:saved, skill_unit})

        {:noreply,
         socket
         |> put_flash(:info, "Skill unit updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_skill_unit(socket, :new, skill_unit_params) do
    case SkillUnits.create_skill_unit(skill_unit_params) do
      {:ok, skill_unit} ->
        notify_parent({:saved, skill_unit})

        {:noreply,
         socket
         |> put_flash(:info, "Skill unit created successfully")
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
