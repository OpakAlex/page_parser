defmodule PageParserTest do
  use ExUnit.Case
  doctest PageParser

  alias PageParser.{Cache, Fetcher, Result}

  import Mock

  describe "fetch" do
    test "returs result from cache" do
      with_mock(Cache, [lookup: fn(_,_) -> %Result{} end, store: fn(_,_,_) -> nil end]) do
        assert PageParser.fetch("https://google.com") == {:ok, %Result{}}
        assert PageParser.fetch("https://google.com", cache: true) == {:ok, %Result{}}
      end
    end

    test "returns result without cache" do
      with_mock(Fetcher, [get: fn(_) -> {:ok, %Result{}} end]) do
        assert PageParser.fetch("https://google.com", cache: false) == {:ok, %Result{}}
      end
    end
  end

  describe "fetch!" do
    test "returs result from cache" do
      with_mock(Cache, [lookup: fn(_,_) -> %Result{} end, store: fn(_,_,_) -> nil end]) do
        assert PageParser.fetch!("https://google.com") == %Result{}
        assert PageParser.fetch!("https://google.com", cache: true) == %Result{}
      end
    end

    test "returns result without cache" do
      with_mock(Fetcher, [get: fn(_) -> {:ok, %Result{}} end]) do
        assert PageParser.fetch!("https://google.com", cache: false) == %Result{}
      end
    end
  end
end
