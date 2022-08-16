defmodule App.Repo.Migrations.CreateMoods do
  use Ecto.Migration

  def change do
    create table(:moods) do
      add :rating, :integer
      add :notes, :string

      timestamps()
    end
  end
end
