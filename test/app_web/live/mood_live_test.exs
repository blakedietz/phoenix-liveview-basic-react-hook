defmodule AppWeb.MoodLiveTest do
  use AppWeb.ConnCase

  import Phoenix.LiveViewTest
  import App.PersonalMetricsFixtures

  @create_attrs %{notes: "some notes", rating: 42}
  @update_attrs %{notes: "some updated notes", rating: 43}
  @invalid_attrs %{notes: nil, rating: nil}

  defp create_mood(_) do
    mood = mood_fixture()
    %{mood: mood}
  end

  describe "Index" do
    setup [:create_mood]

    test "lists all moods", %{conn: conn, mood: mood} do
      {:ok, _index_live, html} = live(conn, Routes.mood_index_path(conn, :index))

      assert html =~ "Listing Moods"
      assert html =~ mood.notes
    end

    test "saves new mood", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.mood_index_path(conn, :index))

      assert index_live |> element("a", "New Mood") |> render_click() =~
               "New Mood"

      assert_patch(index_live, Routes.mood_index_path(conn, :new))

      assert index_live
             |> form("#mood-form", mood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mood-form", mood: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mood_index_path(conn, :index))

      assert html =~ "Mood created successfully"
      assert html =~ "some notes"
    end

    test "updates mood in listing", %{conn: conn, mood: mood} do
      {:ok, index_live, _html} = live(conn, Routes.mood_index_path(conn, :index))

      assert index_live |> element("#mood-#{mood.id} a", "Edit") |> render_click() =~
               "Edit Mood"

      assert_patch(index_live, Routes.mood_index_path(conn, :edit, mood))

      assert index_live
             |> form("#mood-form", mood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mood-form", mood: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mood_index_path(conn, :index))

      assert html =~ "Mood updated successfully"
      assert html =~ "some updated notes"
    end

    test "deletes mood in listing", %{conn: conn, mood: mood} do
      {:ok, index_live, _html} = live(conn, Routes.mood_index_path(conn, :index))

      assert index_live |> element("#mood-#{mood.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mood-#{mood.id}")
    end
  end

  describe "Show" do
    setup [:create_mood]

    test "displays mood", %{conn: conn, mood: mood} do
      {:ok, _show_live, html} = live(conn, Routes.mood_show_path(conn, :show, mood))

      assert html =~ "Show Mood"
      assert html =~ mood.notes
    end

    test "updates mood within modal", %{conn: conn, mood: mood} do
      {:ok, show_live, _html} = live(conn, Routes.mood_show_path(conn, :show, mood))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mood"

      assert_patch(show_live, Routes.mood_show_path(conn, :edit, mood))

      assert show_live
             |> form("#mood-form", mood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#mood-form", mood: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mood_show_path(conn, :show, mood))

      assert html =~ "Mood updated successfully"
      assert html =~ "some updated notes"
    end
  end
end
