defmodule HTTPSpellCheck do
  use HTTPoison.Base

  @service_host "https://api.projectoxford.ai/text/v1.0/"
  @subscriptionKeyName :"ocp-apim-subscription-key"
  @subscriptionKey #"your-api-key"

  def process_url(url) do
    @service_host  <> url
  end

  def process_request_headers(headers) do
    Dict.put headers, @subscriptionKeyName, @subscriptionKey
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end
end
