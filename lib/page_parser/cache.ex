defmodule PageParser.Cache do
  @moduledoc """
  This module provides functionality to store/lookup cache data.
  Uses genserver behaviour
  """

  use GenServer

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def store(server, name, value) do
    GenServer.cast(server, {:store, name, value})
  end

  def reset(server) do
    GenServer.cast(server, {:reset})
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {:reply, state[name], state}
  end

  @impl true
  def handle_cast({:store, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl true
  def handle_cast({:reset}, _state) do
    {:noreply, %{}}
  end
end
