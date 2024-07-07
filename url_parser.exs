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

    [path, parameters] = case String.split(path, "?") do
      [path, parameters] -> [path, parse_parameters(parameters)]
      [path] -> [path, %{}]
    end
    
    %UrlParser{protocol: protocol, host: host, port: port, path: path, parameters: parameters}
  end

  def parse_parameters(str) do
    parameters = String.split(str, "&")
    parse_keys(parameters, %{})
  end

  def parse_keys([], acc) do 
    acc
  end

  def parse_keys([head | tail], acc) do
    [key, value] = String.split(head, "=")
    acc = Map.put(acc, key, value)
    parse_keys(tail, acc)
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
      parameters: %{}
    }
  end

  test "HTTP URL" do
    dbg(UrlParser.parse("http://www.google.com/"))
    assert UrlParser.parse("http://www.google.com/") == %UrlParser{
      protocol: "http",
      host: "www.google.com",
      port: "80",
      path: "/",
      parameters: %{}
    }
end

  test "URL with port" do
    dbg(UrlParser.parse("https://www.google.com:8000/"))
    assert UrlParser.parse("https://www.google.com:8000/") == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: "8000",
      path: "/",
      parameters: %{}
    }
  end

  test "URL with path " do
    dbg(UrlParser.parse("https://www.google.com/search"))
    assert UrlParser.parse("https://www.google.com/search") == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: "443",
      path: "/search",
      parameters: %{}
    }
  end

  test "URL with path and parameters" do
    dbg(UrlParser.parse("https://www.google.com/search?q=elixir&lang=en"))
    assert UrlParser.parse("https://www.google.com/search?q=elixir&lang=en") == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: "443",
      path: "/search",
      parameters: %{ "q" => "elixir", "lang" => "en"}
    }
  end
end
