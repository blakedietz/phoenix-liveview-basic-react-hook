defmodule App.PersonalMetrics do
  @moduledoc """
  The PersonalMetrics context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.PersonalMetrics.Mood

  @doc """
  Returns the list of moods.

  ## Examples

      iex> list_moods()
      [%Mood{}, ...]

  """
  def list_moods do
    Repo.all(Mood)
  end

  @doc """
  Gets a single mood.

  Raises `Ecto.NoResultsError` if the Mood does not exist.

  ## Examples

      iex> get_mood!(123)
      %Mood{}

      iex> get_mood!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mood!(id), do: Repo.get!(Mood, id)

  @doc """
  Creates a mood.

  ## Examples

      iex> create_mood(%{field: value})
      {:ok, %Mood{}}

      iex> create_mood(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mood(attrs \\ %{}) do
    %Mood{}
    |> Mood.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mood.

  ## Examples

      iex> update_mood(mood, %{field: new_value})
      {:ok, %Mood{}}

      iex> update_mood(mood, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mood(%Mood{} = mood, attrs) do
    mood
    |> Mood.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mood.

  ## Examples

      iex> delete_mood(mood)
      {:ok, %Mood{}}

      iex> delete_mood(mood)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mood(%Mood{} = mood) do
    Repo.delete(mood)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mood changes.

  ## Examples

      iex> change_mood(mood)
      %Ecto.Changeset{data: %Mood{}}

  """
  def change_mood(%Mood{} = mood, attrs \\ %{}) do
    Mood.changeset(mood, attrs)
  end
end
