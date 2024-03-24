defmodule BasicWeb.SkillUnitLiveTest do
  use BasicWeb.ConnCase

  import Phoenix.LiveViewTest
  import Basic.SkillUnitsFixtures

  @create_attrs %{loced_date: "2024-03-23T02:22:00", name: "some name", trace_id: 42}
  @update_attrs %{loced_date: "2024-03-24T02:22:00", name: "some updated name", trace_id: 43}
  @invalid_attrs %{loced_date: nil, name: nil, trace_id: nil}

  defp create_skill_unit(_) do
    skill_unit = skill_unit_fixture()
    %{skill_unit: skill_unit}
  end

  describe "Index" do
    setup [:create_skill_unit]

    test "lists all skill_units", %{conn: conn, skill_unit: skill_unit} do
      {:ok, _index_live, html} = live(conn, ~p"/skill_units")

      assert html =~ "Listing Skill units"
      assert html =~ skill_unit.name
    end

    test "saves new skill_unit", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_units")

      assert index_live |> element("a", "New Skill unit") |> render_click() =~
               "New Skill unit"

      assert_patch(index_live, ~p"/skill_units/new")

      assert index_live
             |> form("#skill_unit-form", skill_unit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#skill_unit-form", skill_unit: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/skill_units")

      html = render(index_live)
      assert html =~ "Skill unit created successfully"
      assert html =~ "some name"
    end

    test "updates skill_unit in listing", %{conn: conn, skill_unit: skill_unit} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_units")

      assert index_live |> element("#skill_units-#{skill_unit.id} a", "Edit") |> render_click() =~
               "Edit Skill unit"

      assert_patch(index_live, ~p"/skill_units/#{skill_unit}/edit")

      assert index_live
             |> form("#skill_unit-form", skill_unit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#skill_unit-form", skill_unit: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/skill_units")

      html = render(index_live)
      assert html =~ "Skill unit updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes skill_unit in listing", %{conn: conn, skill_unit: skill_unit} do
      {:ok, index_live, _html} = live(conn, ~p"/skill_units")

      assert index_live |> element("#skill_units-#{skill_unit.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#skill_units-#{skill_unit.id}")
    end
  end

  describe "Show" do
    setup [:create_skill_unit]

    test "displays skill_unit", %{conn: conn, skill_unit: skill_unit} do
      {:ok, _show_live, html} = live(conn, ~p"/skill_units/#{skill_unit}")

      assert html =~ "Show Skill unit"
      assert html =~ skill_unit.name
    end

    test "updates skill_unit within modal", %{conn: conn, skill_unit: skill_unit} do
      {:ok, show_live, _html} = live(conn, ~p"/skill_units/#{skill_unit}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Skill unit"

      assert_patch(show_live, ~p"/skill_units/#{skill_unit}/show/edit")

      assert show_live
             |> form("#skill_unit-form", skill_unit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#skill_unit-form", skill_unit: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/skill_units/#{skill_unit}")

      html = render(show_live)
      assert html =~ "Skill unit updated successfully"
      assert html =~ "some updated name"
    end
  end
end
