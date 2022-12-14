require "application_system_test_case"

class PhysiciansTest < ApplicationSystemTestCase
  setup do
    @physician = physicians(:one)
  end

  test "visiting the index" do
    visit physicians_url
    assert_selector "h1", text: "Physicians"
  end

  test "should create physician" do
    visit physicians_url
    click_on "New physician"

    click_on "Create Physician"

    assert_text "Physician was successfully created"
    click_on "Back"
  end

  test "should update Physician" do
    visit physician_url(@physician)
    click_on "Edit this physician", match: :first

    click_on "Update Physician"

    assert_text "Physician was successfully updated"
    click_on "Back"
  end

  test "should destroy Physician" do
    visit physician_url(@physician)
    click_on "Destroy this physician", match: :first

    assert_text "Physician was successfully destroyed"
  end
end
