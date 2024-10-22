require "application_system_test_case"

class EspecialidadesTest < ApplicationSystemTestCase
  setup do
    @especialidade = especialidades(:one)
  end

  test "visiting the index" do
    visit especialidades_url
    assert_selector "h1", text: "Especialidades"
  end

  test "should create especialidade" do
    visit especialidades_url
    click_on "New especialidade"

    fill_in "Area", with: @especialidade.area_id
    fill_in "Descricao", with: @especialidade.descricao
    click_on "Create Especialidade"

    assert_text "Especialidade was successfully created"
    click_on "Back"
  end

  test "should update Especialidade" do
    visit especialidade_url(@especialidade)
    click_on "Edit this especialidade", match: :first

    fill_in "Area", with: @especialidade.area_id
    fill_in "Descricao", with: @especialidade.descricao
    click_on "Update Especialidade"

    assert_text "Especialidade was successfully updated"
    click_on "Back"
  end

  test "should destroy Especialidade" do
    visit especialidade_url(@especialidade)
    click_on "Destroy this especialidade", match: :first

    assert_text "Especialidade was successfully destroyed"
  end
end
