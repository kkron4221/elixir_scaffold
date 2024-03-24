defmodule BasicWeb.SkillCategoryLiveTest do
  use BasicWeb.ConnCase

  import Phoenix.LiveViewTest
  import Basic.SkillUnitsFixtures

  @create_attrs %{name: "some name", position: 42, trace_id: 42}
  @update_attrs %{name: "some updated name", position: 43, trace_id: 43}
  @invalid_attrs %{name: nil, position: nil, trace_id: nil}

  defp create_skill_category(_) do
    skill_category = skill_category_fixture()
    %{skill_category: skill_category}
  end

  describe "Index" do
    setup [:create_skill_category]

    test "lists all skill_categories", %{conn: conn, skill_category: skill_category} do
      {:ok, _index_live, html} = live(conn, ~p"/skill_categories")

      assert html =~ "Listing Skill categories"
      assert html =~ skill_category.name
    end

    test "saves new skill_category", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_categories")

      assert index_live |> element("a", "New Skill category") |> render_click() =~
               "New Skill category"

      assert_patch(index_live, ~p"/skill_categories/new")

      assert index_live
             |> form("#skill_category-form", skill_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#skill_category-form", skill_category: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/skill_categories")

      html = render(index_live)
      assert html =~ "Skill category created successfully"
      assert html =~ "some name"
    end

    test "updates skill_category in listing", %{conn: conn, skill_category: skill_category} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_categories")

      assert index_live |> element("#skill_categories-#{skill_category.id} a", "Edit") |> render_click() =~
               "Edit Skill category"

      assert_patch(index_live, ~p"/skill_categories/#{skill_category}/edit")

      assert index_live
             |> form("#skill_category-form", skill_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#skill_category-form", skill_category: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/skill_categories")

      html = render(index_live)
      assert html =~ "Skill category updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes skill_category in listing", %{conn: conn, skill_category: skill_category} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_categories")

      assert index_live |> element("#skill_categories-#{skill_category.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#skill_categories-#{skill_category.id}")
    end
  end

  describe "Show" do
    setup [:create_skill_category]

    test "displays skill_category", %{conn: conn, skill_category: skill_category} do
      {:ok, _show_live, html} = live(conn, ~p"/skill_categories/#{skill_category}")

      assert html =~ "Show Skill category"
      assert html =~ skill_category.name
    end

    test "updates skill_category within modal", %{conn: conn, skill_category: skill_category} do
      {:ok, show_live, _html} = live(conn, ~p"/skill_categories/#{skill_category}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Skill category"

      assert_patch(show_live, ~p"/skill_categories/#{skill_category}/show/edit")

      assert show_live
             |> form("#skill_category-form", skill_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#skill_category-form", skill_category: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/skill_categories/#{skill_category}")

      html = render(show_live)
      assert html =~ "Skill category updated successfully"
      assert html =~ "some updated name"
    end
  end
end
