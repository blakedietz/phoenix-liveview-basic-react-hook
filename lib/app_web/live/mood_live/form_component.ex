defmodule AppWeb.MoodLive.FormComponent do
  use AppWeb, :live_component

  alias App.PersonalMetrics

  @impl true
  def update(%{mood: mood} = assigns, socket) do
    changeset = PersonalMetrics.change_mood(mood)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"mood" => mood_params}, socket) do
    changeset =
      socket.assigns.mood
      |> PersonalMetrics.change_mood(mood_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"mood" => mood_params}, socket) do
    save_mood(socket, socket.assigns.action, mood_params)
  end

  defp save_mood(socket, :edit, mood_params) do
    case PersonalMetrics.update_mood(socket.assigns.mood, mood_params) do
      {:ok, _mood} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mood updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_mood(socket, :new, mood_params) do
    case PersonalMetrics.create_mood(mood_params) do
      {:ok, _mood} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mood created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
