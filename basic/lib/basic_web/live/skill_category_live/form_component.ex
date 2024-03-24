defmodule BasicWeb.SkillCategoryLive.FormComponent do
  use BasicWeb, :live_component

  alias Basic.SkillUnits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage skill_category records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="skill_category-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:position]} type="number" label="Position" />
        <.input field={@form[:trace_id]} type="number" label="Trace" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Skill category</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{skill_category: skill_category} = assigns, socket) do
    changeset = SkillUnits.change_skill_category(skill_category)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"skill_category" => skill_category_params}, socket) do
    changeset =
      socket.assigns.skill_category
      |> SkillUnits.change_skill_category(skill_category_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"skill_category" => skill_category_params}, socket) do
    save_skill_category(socket, socket.assigns.action, skill_category_params)
  end

  defp save_skill_category(socket, :edit, skill_category_params) do
    case SkillUnits.update_skill_category(socket.assigns.skill_category, skill_category_params) do
      {:ok, skill_category} ->
        notify_parent({:saved, skill_category})

        {:noreply,
         socket
         |> put_flash(:info, "Skill category updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_skill_category(socket, :new, skill_category_params) do
    case SkillUnits.create_skill_category(skill_category_params) do
      {:ok, skill_category} ->
        notify_parent({:saved, skill_category})

        {:noreply,
         socket
         |> put_flash(:info, "Skill category created successfully")
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
