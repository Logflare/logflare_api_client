defmodule LogflareApiClientTest do
  use ExUnit.Case
  alias LogflareApiClient
  alias LogflareApiClient.TestUtils
  require Logger

  @port 4444
  @path LogflareApiClient.api_path()

  @api_key "l3kh47jsakf2370dasg"
  @source_id "source2354551"

  setup do
    bypass = Bypass.open(port: @port)

    {:ok, bypass: bypass}
  end

  test "ApiClient sends a correct POST request with gzip in bert format", %{bypass: bypass} do
    response = Jason.encode!(%{"response" => "success"})

    Bypass.expect_once(bypass, "POST", @path, fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn)
      assert {"x-api-key", @api_key} in conn.req_headers

      body = TestUtils.decode_logger_body(body)

      assert %{
               "batch" => [
                 %{
                   "context" => %{"system" => %{"file" => "not_existing.ex"}},
                   "level" => "info",
                   "message" => "Logger message"
                 }
               ],
               "source" => "source2354551"
             } = body

      Plug.Conn.resp(conn, 200, response)
    end)

    client = LogflareApiClient.new(%{api_key: @api_key, url: "http://localhost:#{@port}"})

    batch = [
      %{
        "level" => "info",
        "message" => "Logger message",
        "context" => %{
          "system" => %{
            "file" => "not_existing.ex"
          }
        }
      }
    ]

    {:ok, %{body: body}} = LogflareApiClient.post_logs(client, batch, @source_id)

    assert body == response
  end
end
