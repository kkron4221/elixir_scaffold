defmodule Basic.SkillUnits do
  @moduledoc """
  The SkillUnits context.
  """

  import Ecto.Query, warn: false
  alias Basic.Repo

  alias Basic.SkillUnits.SkillUnit

  @doc """
  Returns the list of skill_units.

  ## Examples

      iex> list_skill_units()
      [%SkillUnit{}, ...]

  """
  def list_skill_units do
    Repo.all(SkillUnit)
  end

  @doc """
  Gets a single skill_unit.

  Raises `Ecto.NoResultsError` if the Skill unit does not exist.

  ## Examples

      iex> get_skill_unit!(123)
      %SkillUnit{}

      iex> get_skill_unit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_skill_unit!(id), do: Repo.get!(SkillUnit, id)

  @doc """
  Creates a skill_unit.

  ## Examples

      iex> create_skill_unit(%{field: value})
      {:ok, %SkillUnit{}}

      iex> create_skill_unit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_skill_unit(attrs \\ %{}) do
    %SkillUnit{}
    |> SkillUnit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a skill_unit.

  ## Examples

      iex> update_skill_unit(skill_unit, %{field: new_value})
      {:ok, %SkillUnit{}}

      iex> update_skill_unit(skill_unit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_skill_unit(%SkillUnit{} = skill_unit, attrs) do
    skill_unit
    |> SkillUnit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a skill_unit.

  ## Examples

      iex> delete_skill_unit(skill_unit)
      {:ok, %SkillUnit{}}

      iex> delete_skill_unit(skill_unit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_skill_unit(%SkillUnit{} = skill_unit) do
    Repo.delete(skill_unit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking skill_unit changes.

  ## Examples

      iex> change_skill_unit(skill_unit)
      %Ecto.Changeset{data: %SkillUnit{}}

  """
  def change_skill_unit(%SkillUnit{} = skill_unit, attrs \\ %{}) do
    SkillUnit.changeset(skill_unit, attrs)
  end

  alias Basic.SkillUnits.SkillCategory

  @doc """
  Returns the list of skill_categories.

  ## Examples

      iex> list_skill_categories()
      [%SkillCategory{}, ...]

  """
  def list_skill_categories do
    Repo.all(SkillCategory)
  end

  @doc """
  Gets a single skill_category.

  Raises `Ecto.NoResultsError` if the Skill category does not exist.

  ## Examples

      iex> get_skill_category!(123)
      %SkillCategory{}

      iex> get_skill_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_skill_category!(id), do: Repo.get!(SkillCategory, id)

  @doc """
  Creates a skill_category.

  ## Examples

      iex> create_skill_category(%{field: value})
      {:ok, %SkillCategory{}}

      iex> create_skill_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_skill_category(attrs \\ %{}) do
    %SkillCategory{}
    |> SkillCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a skill_category.

  ## Examples

      iex> update_skill_category(skill_category, %{field: new_value})
      {:ok, %SkillCategory{}}

      iex> update_skill_category(skill_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_skill_category(%SkillCategory{} = skill_category, attrs) do
    skill_category
    |> SkillCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a skill_category.

  ## Examples

      iex> delete_skill_category(skill_category)
      {:ok, %SkillCategory{}}

      iex> delete_skill_category(skill_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_skill_category(%SkillCategory{} = skill_category) do
    Repo.delete(skill_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking skill_category changes.

  ## Examples

      iex> change_skill_category(skill_category)
      %Ecto.Changeset{data: %SkillCategory{}}

  """
  def change_skill_category(%SkillCategory{} = skill_category, attrs \\ %{}) do
    SkillCategory.changeset(skill_category, attrs)
  end

  alias Basic.SkillUnits.Skill

  @doc """
  Returns the list of skills.

  ## Examples

      iex> list_skills()
      [%Skill{}, ...]

  """
  def list_skills do
    Repo.all(Skill)
  end

  alias Bright.SkillScores.SkillScore
  def list_skills_with_scores(nil), do: []
  def list_skills_with_scores(user_id) do
    Repo.all(from skill in Skill,
      left_join: score in SkillScore,
      on: ^user_id == score.user_id and (skill.id == score.skill or is_nil(score.skill_id)),
      order_by: skill.id,
      preload: [skill_scores: score])
  end

  @doc """
  Gets a single skill.

  Raises `Ecto.NoResultsError` if the Skill does not exist.

  ## Examples

      iex> get_skill!(123)
      %Skill{}

      iex> get_skill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_skill!(id), do: Repo.get!(Skill, id)

  @doc """
  Creates a skill.

  ## Examples

      iex> create_skill(%{field: value})
      {:ok, %Skill{}}

      iex> create_skill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_skill(attrs \\ %{}) do
    %Skill{}
    |> Skill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a skill.

  ## Examples

      iex> update_skill(skill, %{field: new_value})
      {:ok, %Skill{}}

      iex> update_skill(skill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_skill(%Skill{} = skill, attrs) do
    skill
    |> Skill.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a skill.

  ## Examples

      iex> delete_skill(skill)
      {:ok, %Skill{}}

      iex> delete_skill(skill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_skill(%Skill{} = skill) do
    Repo.delete(skill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking skill changes.

  ## Examples

      iex> change_skill(skill)
      %Ecto.Changeset{data: %Skill{}}

  """
  def change_skill(%Skill{} = skill, attrs \\ %{}) do
    Skill.changeset(skill, attrs)
  end
end
