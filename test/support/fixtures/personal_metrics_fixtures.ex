defmodule App.PersonalMetricsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.PersonalMetrics` context.
  """

  @doc """
  Generate a mood.
  """
  def mood_fixture(attrs \\ %{}) do
    {:ok, mood} =
      attrs
      |> Enum.into(%{
        notes: "some notes",
        rating: 42
      })
      |> App.PersonalMetrics.create_mood()

    mood
  end
end
