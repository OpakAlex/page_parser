defmodule PageParser do
  @moduledoc """
  This module provides functionality to parse given urls.
  """
  alias PageParser.{Cache, Fetcher, Result}

  use Application

  @doc """
  Starts GenServer with application
  """
  @impl true
  def start(_type, _args) do
    Cache.start_link(name: PageParser.Cache)
  end

  @doc """
  Parses given url, and returns `Result.t()`
  If an error happens returns nil.
  By default it uses cache, if you don't want to lookup and write to cache, use additional
  option `cache: false`
  Usage example: fetch!("https://***") or fetch!("https://***", cache: false)
  """

  @spec fetch(String.t(), Keyword.t()) :: Result.t() | Macro.t()
  def fetch!(url, options \\ []) do
    case _fetch(url, options) do
      {:error, reason} -> raise reason
      {:ok, result} -> result
    end
  end

  @doc """
  Parses given url, and returns tuple {:ok, Result.t()} or {:error, reason}
  By default it uses cache, if you don't want to lookup and write to cache, use additional
  option `cache: false`
  Usage example: fetch("https://***") or fetch("https://***", cache: false)
  """

  @spec fetch(String.t(), Keyword.t()) :: {:ok, Result.t()} | {:error, term}
  def fetch(url, options \\ []) do
    _fetch(url, options)
  end

  @spec fetch_from_cache(String.t()) :: {:ok, Result.t()} | {:error, term}
  defp fetch_from_cache(url) do
    case Cache.lookup(PageParser.Cache, url) do
      nil -> fetch_and_write_to_cache(url)
      result -> {:ok, result}
    end
  end

  @spec fetch_and_write_to_cache(String.t()) :: {:ok, Result.t()} | {:error, term}
  def fetch_and_write_to_cache(url) do
    case parse(url) do
      {:error, reason} -> {:error, reason}
      {:ok, result} ->
        Cache.store(PageParser.Cache, url, result)
        {:ok, result}
    end
  end

  @spec _fetch(String.t(), Keyword.t()) :: {:ok, Result.t()} | {:error, term}
  defp _fetch(url, options) do
    cache = Keyword.get(options, :cache, true)
    if cache do
      fetch_from_cache(url)
    else
      parse(url)
    end
  end

  @spec parse(String.t()) :: {:ok, Result.t()} | {:error, term}
  def parse(url) do
    Fetcher.get(url)
  end
end
