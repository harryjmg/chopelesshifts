require "application_system_test_case"

class PlanningsTest < ApplicationSystemTestCase
  setup do
    @planning = plannings(:one)
  end

  test "visiting the index" do
    visit plannings_url
    assert_selector "h1", text: "Plannings"
  end

  test "should create planning" do
    visit plannings_url
    click_on "New planning"

    fill_in "Name", with: @planning.name
    fill_in "State", with: @planning.state
    fill_in "Type", with: @planning.type
    click_on "Create Planning"

    assert_text "Planning was successfully created"
    click_on "Back"
  end

  test "should update Planning" do
    visit planning_url(@planning)
    click_on "Edit this planning", match: :first

    fill_in "Name", with: @planning.name
    fill_in "State", with: @planning.state
    fill_in "Type", with: @planning.type
    click_on "Update Planning"

    assert_text "Planning was successfully updated"
    click_on "Back"
  end

  test "should destroy Planning" do
    visit planning_url(@planning)
    click_on "Destroy this planning", match: :first

    assert_text "Planning was successfully destroyed"
  end
end
