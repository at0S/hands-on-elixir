defmodule UrlParser do
  defstruct [:protocol, :host, :port , :path, :parameters]
  def parse(url) do
      [protocol, tail] = String.split(url, "://")
      [host, tail] =  String.split(tail, "/")
    
    port = case protocol do
      "https" -> 443
      "http"  -> 80
    end

    path = case tail do
      nil -> "/"
      _ -> "/" <> tail
    end

    %UrlParser{protocol: protocol, host: host, port: port, path: path, parameters: %{}}
  end
end

ExUnit.start()
defmodule UrlParserTest do
  use ExUnit.Case


  test "HTTPS URL" do
      assert UrlParser.parse("https://www.google.com/") == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: 443,
      path: "/",
      parameters: %{}
    }
  end

#  test "HTTP URL" do
#    input_url = "https://www.google.com/"
#    assert UrlParser.parse(input_url) == %UrlParser{
#      protocol: "https",
#      host: "www.google.com",
#      port: 80,
#      path: "/",
#    }
#end

#  test "URL with port" do
#    input_url = "https://www.google.com:8000/"
#    assert UrlParser.parse(input_url) == %UrlParser{
#      protocol: "https",
#      host: "www.google.com",
#      port: 8000,
#      path: "/",
#    }
#  end

#  test "URL with path " do
#    input_url = "https://www.google.com/search"
#    assert UrlParser.parse(input_url) == %UrlParser{
#      protocol: "https",
#      host: "www.google.com",
#      port: 443,
#      path: "/search",
#    }
#  end

#  test "URL with path and parameters" do
#    input_url = "https://www.google.com/search?q=elixir"
#    assert UrlParser.parse(input_url) == %UrlParser{
#      protocol: "https",
#      host: "www.google.com",
#      port: 443,
#      path: "/",
#      parameters: %{ "q" => "elixir"}
#    }
#  end
end
