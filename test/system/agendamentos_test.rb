require "application_system_test_case"

class AgendamentosTest < ApplicationSystemTestCase
  setup do
    @agendamento = agendamentos(:one)
  end

  test "visiting the index" do
    visit agendamentos_url
    assert_selector "h1", text: "Agendamentos"
  end

  test "should create agendamento" do
    visit agendamentos_url
    click_on "New agendamento"

    fill_in "Cliente", with: @agendamento.cliente_id
    fill_in "Consultor", with: @agendamento.consultor_id
    fill_in "Data", with: @agendamento.data
    fill_in "Hora fim", with: @agendamento.hora_fim
    fill_in "Hora inicio", with: @agendamento.hora_inicio
    click_on "Create Agendamento"

    assert_text "Agendamento was successfully created"
    click_on "Back"
  end

  test "should update Agendamento" do
    visit agendamento_url(@agendamento)
    click_on "Edit this agendamento", match: :first

    fill_in "Cliente", with: @agendamento.cliente_id
    fill_in "Consultor", with: @agendamento.consultor_id
    fill_in "Data", with: @agendamento.data
    fill_in "Hora fim", with: @agendamento.hora_fim
    fill_in "Hora inicio", with: @agendamento.hora_inicio
    click_on "Update Agendamento"

    assert_text "Agendamento was successfully updated"
    click_on "Back"
  end

  test "should destroy Agendamento" do
    visit agendamento_url(@agendamento)
    click_on "Destroy this agendamento", match: :first

    assert_text "Agendamento was successfully destroyed"
  end
end
