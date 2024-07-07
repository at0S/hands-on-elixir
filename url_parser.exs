defmodule UrlParser do

end

ExUnit.start()

defmodule UrlParserTest do
  use ExUnit.Case


  test "HTTPS URL" do
    input_url = "https://www.google.com/"
    assert UrlParser.parse(input_url) == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: 443,
      path: "/",
    }
  end

  test "HTTP URL" do
    input_url = "https://www.google.com/"
    assert UrlParser.parse(input_url) == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: 80,
      path: "/",
    }
  end

  test "URL with port" do
    input_url = "https://www.google.com:8000/"
    assert UrlParser.parse(input_url) == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: 8000,
      path: "/",
    }
  end

  test "URL with path " do
    input_url = "https://www.google.com/search"
    assert UrlParser.parse(input_url) == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: 443,
      path: "/search",
    }
  end

  test "URL with path and parameters" do
    input_url = "https://www.google.com/search?q=elixir"
    assert UrlParser.parse(input_url) == %UrlParser{
      protocol: "https",
      host: "www.google.com",
      port: 443,
      path: "/",
      parameters: %{ "q" => "elixir"}
    }
  end
end
