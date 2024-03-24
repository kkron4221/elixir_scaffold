defmodule BrightWeb.SkillScoreLive.FormComponent do
  use BrightWeb, :live_component

  alias Bright.SkillScores

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage skill_score records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="skill_score-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:user_id]} type="number" label="User" />
        <.input field={@form[:skill_id]} type="number" label="Skill" />
        <.input field={@form[:score]} type="text" label="Score" />
        <.input field={@form[:exam_progress]} type="text" label="Exam progress" />
        <.input field={@form[:reference_read]} type="checkbox" label="Reference read" />
        <.input field={@form[:evidence_filled]} type="checkbox" label="Evidence filled" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Skill score</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{skill_score: skill_score} = assigns, socket) do
    changeset = SkillScores.change_skill_score(skill_score)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"skill_score" => skill_score_params}, socket) do
    changeset =
      socket.assigns.skill_score
      |> SkillScores.change_skill_score(skill_score_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"skill_score" => skill_score_params}, socket) do
    save_skill_score(socket, socket.assigns.action, skill_score_params)
  end

  defp save_skill_score(socket, :edit, skill_score_params) do
    case SkillScores.update_skill_score(socket.assigns.skill_score, skill_score_params) do
      {:ok, skill_score} ->
        notify_parent({:saved, skill_score})

        {:noreply,
         socket
         |> put_flash(:info, "Skill score updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_skill_score(socket, :new, skill_score_params) do
    case SkillScores.create_skill_score(skill_score_params) do
      {:ok, skill_score} ->
        notify_parent({:saved, skill_score})

        {:noreply,
         socket
         |> put_flash(:info, "Skill score created successfully")
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
