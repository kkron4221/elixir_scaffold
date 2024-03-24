defmodule Basic.SkillUnitsTest do
  use Basic.DataCase

  alias Basic.SkillUnits

  describe "skill_units" do
    alias Basic.SkillUnits.SkillUnit

    import Basic.SkillUnitsFixtures

    @invalid_attrs %{loced_date: nil, name: nil, trace_id: nil}

    test "list_skill_units/0 returns all skill_units" do
      skill_unit = skill_unit_fixture()
      assert SkillUnits.list_skill_units() == [skill_unit]
    end

    test "get_skill_unit!/1 returns the skill_unit with given id" do
      skill_unit = skill_unit_fixture()
      assert SkillUnits.get_skill_unit!(skill_unit.id) == skill_unit
    end

    test "create_skill_unit/1 with valid data creates a skill_unit" do
      valid_attrs = %{loced_date: ~N[2024-03-23 02:22:00], name: "some name", trace_id: 42}

      assert {:ok, %SkillUnit{} = skill_unit} = SkillUnits.create_skill_unit(valid_attrs)
      assert skill_unit.loced_date == ~N[2024-03-23 02:22:00]
      assert skill_unit.name == "some name"
      assert skill_unit.trace_id == 42
    end

    test "create_skill_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SkillUnits.create_skill_unit(@invalid_attrs)
    end

    test "update_skill_unit/2 with valid data updates the skill_unit" do
      skill_unit = skill_unit_fixture()
      update_attrs = %{loced_date: ~N[2024-03-24 02:22:00], name: "some updated name", trace_id: 43}

      assert {:ok, %SkillUnit{} = skill_unit} = SkillUnits.update_skill_unit(skill_unit, update_attrs)
      assert skill_unit.loced_date == ~N[2024-03-24 02:22:00]
      assert skill_unit.name == "some updated name"
      assert skill_unit.trace_id == 43
    end

    test "update_skill_unit/2 with invalid data returns error changeset" do
      skill_unit = skill_unit_fixture()
      assert {:error, %Ecto.Changeset{}} = SkillUnits.update_skill_unit(skill_unit, @invalid_attrs)
      assert skill_unit == SkillUnits.get_skill_unit!(skill_unit.id)
    end

    test "delete_skill_unit/1 deletes the skill_unit" do
      skill_unit = skill_unit_fixture()
      assert {:ok, %SkillUnit{}} = SkillUnits.delete_skill_unit(skill_unit)
      assert_raise Ecto.NoResultsError, fn -> SkillUnits.get_skill_unit!(skill_unit.id) end
    end

    test "change_skill_unit/1 returns a skill_unit changeset" do
      skill_unit = skill_unit_fixture()
      assert %Ecto.Changeset{} = SkillUnits.change_skill_unit(skill_unit)
    end
  end

  describe "skill_categories" do
    alias Basic.SkillUnits.SkillCategory

    import Basic.SkillUnitsFixtures

    @invalid_attrs %{name: nil, position: nil, trace_id: nil}

    test "list_skill_categories/0 returns all skill_categories" do
      skill_category = skill_category_fixture()
      assert SkillUnits.list_skill_categories() == [skill_category]
    end

    test "get_skill_category!/1 returns the skill_category with given id" do
      skill_category = skill_category_fixture()
      assert SkillUnits.get_skill_category!(skill_category.id) == skill_category
    end

    test "create_skill_category/1 with valid data creates a skill_category" do
      valid_attrs = %{name: "some name", position: 42, trace_id: 42}

      assert {:ok, %SkillCategory{} = skill_category} = SkillUnits.create_skill_category(valid_attrs)
      assert skill_category.name == "some name"
      assert skill_category.position == 42
      assert skill_category.trace_id == 42
    end

    test "create_skill_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SkillUnits.create_skill_category(@invalid_attrs)
    end

    test "update_skill_category/2 with valid data updates the skill_category" do
      skill_category = skill_category_fixture()
      update_attrs = %{name: "some updated name", position: 43, trace_id: 43}

      assert {:ok, %SkillCategory{} = skill_category} = SkillUnits.update_skill_category(skill_category, update_attrs)
      assert skill_category.name == "some updated name"
      assert skill_category.position == 43
      assert skill_category.trace_id == 43
    end

    test "update_skill_category/2 with invalid data returns error changeset" do
      skill_category = skill_category_fixture()
      assert {:error, %Ecto.Changeset{}} = SkillUnits.update_skill_category(skill_category, @invalid_attrs)
      assert skill_category == SkillUnits.get_skill_category!(skill_category.id)
    end

    test "delete_skill_category/1 deletes the skill_category" do
      skill_category = skill_category_fixture()
      assert {:ok, %SkillCategory{}} = SkillUnits.delete_skill_category(skill_category)
      assert_raise Ecto.NoResultsError, fn -> SkillUnits.get_skill_category!(skill_category.id) end
    end

    test "change_skill_category/1 returns a skill_category changeset" do
      skill_category = skill_category_fixture()
      assert %Ecto.Changeset{} = SkillUnits.change_skill_category(skill_category)
    end
  end

  describe "skills" do
    alias Basic.SkillUnits.Skill

    import Basic.SkillUnitsFixtures

    @invalid_attrs %{name: nil, position: nil, trace_id: nil}

    test "list_skills/0 returns all skills" do
      skill = skill_fixture()
      assert SkillUnits.list_skills() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert SkillUnits.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      valid_attrs = %{name: "some name", position: 42, trace_id: 42}

      assert {:ok, %Skill{} = skill} = SkillUnits.create_skill(valid_attrs)
      assert skill.name == "some name"
      assert skill.position == 42
      assert skill.trace_id == 42
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SkillUnits.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      update_attrs = %{name: "some updated name", position: 43, trace_id: 43}

      assert {:ok, %Skill{} = skill} = SkillUnits.update_skill(skill, update_attrs)
      assert skill.name == "some updated name"
      assert skill.position == 43
      assert skill.trace_id == 43
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = SkillUnits.update_skill(skill, @invalid_attrs)
      assert skill == SkillUnits.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = SkillUnits.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> SkillUnits.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = SkillUnits.change_skill(skill)
    end
  end
end
