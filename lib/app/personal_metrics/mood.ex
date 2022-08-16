defmodule App.PersonalMetrics.Mood do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:inserted_at, :notes, :rating]}
  schema "moods" do
    field :notes, :string
    field :rating, :integer

    timestamps()
  end

  @doc false
  def changeset(mood, attrs) do
    mood
    |> cast(attrs, [:rating, :notes])
    |> validate_required([:rating, :notes])
  end
end
