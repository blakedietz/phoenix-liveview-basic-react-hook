defmodule AppWeb.MoodLive.Index do
  use AppWeb, :live_view

  alias App.PersonalMetrics
  alias App.PersonalMetrics.Mood

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :moods, list_moods())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Mood")
    |> assign(:mood, PersonalMetrics.get_mood!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Mood")
    |> assign(:mood, %Mood{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Moods")
    |> assign(:mood, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mood = PersonalMetrics.get_mood!(id)
    {:ok, _} = PersonalMetrics.delete_mood(mood)

    {:noreply, assign(socket, :moods, list_moods())}
  end

  defp list_moods do
    PersonalMetrics.list_moods()
  end
end
