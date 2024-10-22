require "application_system_test_case"

class DisponibilidadeConsultorsTest < ApplicationSystemTestCase
  setup do
    @disponibilidade_consultor = disponibilidade_consultors(:one)
  end

  test "visiting the index" do
    visit disponibilidade_consultors_url
    assert_selector "h1", text: "Disponibilidade consultors"
  end

  test "should create disponibilidade consultor" do
    visit disponibilidade_consultors_url
    click_on "New disponibilidade consultor"

    fill_in "Consultor", with: @disponibilidade_consultor.consultor_id
    fill_in "Data", with: @disponibilidade_consultor.data
    fill_in "Hora fim", with: @disponibilidade_consultor.hora_fim
    fill_in "Hora inicio", with: @disponibilidade_consultor.hora_inicio
    click_on "Create Disponibilidade consultor"

    assert_text "Disponibilidade consultor was successfully created"
    click_on "Back"
  end

  test "should update Disponibilidade consultor" do
    visit disponibilidade_consultor_url(@disponibilidade_consultor)
    click_on "Edit this disponibilidade consultor", match: :first

    fill_in "Consultor", with: @disponibilidade_consultor.consultor_id
    fill_in "Data", with: @disponibilidade_consultor.data
    fill_in "Hora fim", with: @disponibilidade_consultor.hora_fim
    fill_in "Hora inicio", with: @disponibilidade_consultor.hora_inicio
    click_on "Update Disponibilidade consultor"

    assert_text "Disponibilidade consultor was successfully updated"
    click_on "Back"
  end

  test "should destroy Disponibilidade consultor" do
    visit disponibilidade_consultor_url(@disponibilidade_consultor)
    click_on "Destroy this disponibilidade consultor", match: :first

    assert_text "Disponibilidade consultor was successfully destroyed"
  end
end
