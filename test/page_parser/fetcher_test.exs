defmodule PageParser.FetcherTest do
  use ExUnit.Case

  doctest PageParser.Fetcher
  alias PageParser.{Fetcher}

  import Mock

  describe "#get" do
    test "returns links and images from page" do
      html_body = File.read!("test/fixtures/exoplanets.nasa.gov.html")
      with_mock(HTTPoison, [get: fn(_,_,_) -> {:ok, %HTTPoison.Response{status_code: 200, body: html_body}} end]) do
        url = "https://exoplanets.nasa.gov/news"
        {:ok, result } = Fetcher.get(url)
        assert length(result.links) == 131
        assert length(result.images) == 91
      end
    end

    test "returns error if url does not valid" do
      assert Fetcher.get("") == {:error, %CaseClauseError{term: []}}
    end

    test "returns error if request fails" do
      with_mock(HTTPoison, [get: fn(_,_,_) -> {:error, "Error!"} end]) do
        assert Fetcher.get("") == {:error, "Error!"}
      end
    end
  end
end
