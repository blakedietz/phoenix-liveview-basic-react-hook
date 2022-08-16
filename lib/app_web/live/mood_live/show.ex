defmodule AppWeb.MoodLive.Show do
  use AppWeb, :live_view

  alias App.PersonalMetrics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:mood, PersonalMetrics.get_mood!(id))}
  end

  defp page_title(:show), do: "Show Mood"
  defp page_title(:edit), do: "Edit Mood"
end
