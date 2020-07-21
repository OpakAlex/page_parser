defmodule PageParser.CacheTest do
  use ExUnit.Case, async: true

  doctest PageParser.Cache

  alias PageParser.{Cache, Result}

  describe "lookup" do
    test "returns result from cache if cache exists" do
      Cache.reset(Cache)
      Cache.store(Cache, "https://google.com", %Result{})
      assert Cache.lookup(Cache, "https://google.com") == %Result{}
    end

    test "returns nil from cache if cache doest exists" do
      Cache.reset(Cache)
      assert Cache.lookup(Cache, "https://google.com") == nil
    end
  end
end
