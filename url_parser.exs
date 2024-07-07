defmodule UrlParser do
  defstruct [:protocol, :host, :port , :path, :parameters]
  def parse(url) do
      [protocol, tail] = String.split(url, "://")
      [host, tail] =  String.split(tail, "/")
      [host,port] = case String.split(host, ":") do
        [host, port] -> [host, port]
        [host] -> [host, _ = case protocol do
          "https" -> "443"
          "http"  -> "80"
        end ]
      end

      path = case tail do
        nil -> "/"
        _   -> "/" <> tail
      end
      %UrlParser{protocol: protocol, host: host, port: port, path: path}
  end
end

ExUnit.start()
defmodule UrlParserTest do
  use ExUnit.Case

  test "HTTPS URL" do
      dbg(UrlParser.parse("https://www.google.com/"))
      assert UrlParser.parse("https://www.google.com/") == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: "443",
      path: "/",
      parameters: nil
    }
  end

  test "HTTP URL" do
    dbg(UrlParser.parse("http://www.google.com/"))
    assert UrlParser.parse("http://www.google.com/") == %UrlParser{
      protocol: "http",
      host: "www.google.com",
      port: "80",
      path: "/",
      parameters: nil
    }
end

  test "URL with port" do
    dbg(UrlParser.parse("https://www.google.com:8000/"))
    assert UrlParser.parse("https://www.google.com:8000/") == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: "8000",
      path: "/",
    }
  end

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
