defmodule PageParser.Fetcher do
  @moduledoc """
  This module provides functions for parse http url and return result record or error
  """

  alias PageParser.{Result}

  @spec get(String.t()) :: {:ok, Result.t()} | {:error, term}
  def get(url) do
    case request(url) do
      {:error, reason} -> {:error, reason}
      {:ok, result} -> {:ok, parse_request(result)}
    end
  end

  @spec request(String.t()) :: {:ok, HTTPoison.Response.t()} | {:error, term}
  defp request(url) do
    HTTPoison.get(url, [], follow_redirect: true)
    rescue
     e -> {:error, e}
  end

  @spec parse_request(HTTPoison.Response.t()) :: Result.t()
  defp parse_request(result) do
    case Floki.parse_document(result.body) do
      {:ok, document} ->
        %Result{links: parse_links(document), images: parse_images(document)}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec parse_links(List.t()) :: List.t()
  defp parse_links(document) do
    Floki.attribute(document, "a", "href")
  end

  @spec parse_images(List.t()) :: List.t()
  defp parse_images(document) do
    Floki.attribute(document, "img", "src")
  end
end
