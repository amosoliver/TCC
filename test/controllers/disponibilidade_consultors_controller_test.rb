require "test_helper"

class DisponibilidadeConsultorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @disponibilidade_consultor = disponibilidade_consultors(:one)
  end

  test "should get index" do
    get disponibilidade_consultors_url
    assert_response :success
  end

  test "should get new" do
    get new_disponibilidade_consultor_url
    assert_response :success
  end

  test "should create disponibilidade_consultor" do
    assert_difference("DisponibilidadeConsultor.count") do
      post disponibilidade_consultors_url, params: { disponibilidade_consultor: { consultor_id: @disponibilidade_consultor.consultor_id, data: @disponibilidade_consultor.data, hora_fim: @disponibilidade_consultor.hora_fim, hora_inicio: @disponibilidade_consultor.hora_inicio } }
    end

    assert_redirected_to disponibilidade_consultor_url(DisponibilidadeConsultor.last)
  end

  test "should show disponibilidade_consultor" do
    get disponibilidade_consultor_url(@disponibilidade_consultor)
    assert_response :success
  end

  test "should get edit" do
    get edit_disponibilidade_consultor_url(@disponibilidade_consultor)
    assert_response :success
  end

  test "should update disponibilidade_consultor" do
    patch disponibilidade_consultor_url(@disponibilidade_consultor), params: { disponibilidade_consultor: { consultor_id: @disponibilidade_consultor.consultor_id, data: @disponibilidade_consultor.data, hora_fim: @disponibilidade_consultor.hora_fim, hora_inicio: @disponibilidade_consultor.hora_inicio } }
    assert_redirected_to disponibilidade_consultor_url(@disponibilidade_consultor)
  end

  test "should destroy disponibilidade_consultor" do
    assert_difference("DisponibilidadeConsultor.count", -1) do
      delete disponibilidade_consultor_url(@disponibilidade_consultor)
    end

    assert_redirected_to disponibilidade_consultors_url
  end
end
