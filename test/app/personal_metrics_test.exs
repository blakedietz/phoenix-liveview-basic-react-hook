defmodule App.PersonalMetricsTest do
  use App.DataCase

  alias App.PersonalMetrics

  describe "moods" do
    alias App.PersonalMetrics.Mood

    import App.PersonalMetricsFixtures

    @invalid_attrs %{notes: nil, rating: nil}

    test "list_moods/0 returns all moods" do
      mood = mood_fixture()
      assert PersonalMetrics.list_moods() == [mood]
    end

    test "get_mood!/1 returns the mood with given id" do
      mood = mood_fixture()
      assert PersonalMetrics.get_mood!(mood.id) == mood
    end

    test "create_mood/1 with valid data creates a mood" do
      valid_attrs = %{notes: "some notes", rating: 42}

      assert {:ok, %Mood{} = mood} = PersonalMetrics.create_mood(valid_attrs)
      assert mood.notes == "some notes"
      assert mood.rating == 42
    end

    test "create_mood/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PersonalMetrics.create_mood(@invalid_attrs)
    end

    test "update_mood/2 with valid data updates the mood" do
      mood = mood_fixture()
      update_attrs = %{notes: "some updated notes", rating: 43}

      assert {:ok, %Mood{} = mood} = PersonalMetrics.update_mood(mood, update_attrs)
      assert mood.notes == "some updated notes"
      assert mood.rating == 43
    end

    test "update_mood/2 with invalid data returns error changeset" do
      mood = mood_fixture()
      assert {:error, %Ecto.Changeset{}} = PersonalMetrics.update_mood(mood, @invalid_attrs)
      assert mood == PersonalMetrics.get_mood!(mood.id)
    end

    test "delete_mood/1 deletes the mood" do
      mood = mood_fixture()
      assert {:ok, %Mood{}} = PersonalMetrics.delete_mood(mood)
      assert_raise Ecto.NoResultsError, fn -> PersonalMetrics.get_mood!(mood.id) end
    end

    test "change_mood/1 returns a mood changeset" do
      mood = mood_fixture()
      assert %Ecto.Changeset{} = PersonalMetrics.change_mood(mood)
    end
  end
end
