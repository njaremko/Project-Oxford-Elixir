defmodule SpellCheckClient do
  require HTTPSpellCheck
  require Corrector

  def send_req(text, pre \\ "", post \\ "", mode \\ "proof") do

    # Need to create/format content
    # Not sure order matters, but text -> pre -> post -> mode
    query = ["text=" <> text <>
      "&PreContextText=" <> pre <>
      "&PostContextText=" <> post]
    # Escape the string with ~s sigil
    content = ~s(#{query})
    HTTPSpellCheck.post("SpellCheck?mode=" <> mode, content)
  end

  def check(input) do
    case SpellCheckClient.send_req(input) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        correction_map = Map.get(body, "spellingErrors")
        Corrector.construct_correct_text(correction_map, input)
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        IO.puts "Not found :("
      {:ok, %HTTPoison.Response{status_code: 401}} ->
        message = Map.get(body, "message")
        IO.puts message
      {:ok, %HTTPoison.Response{status_code: 403}} ->
        message = Map.get(body, "message")
        IO.puts message
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        message = Map.get(body, "message")
        IO.puts message
      {:ok, %HTTPoison.Response{status_code: 429}} ->
        message = Map.get(body, "message")
        IO.puts message
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end
