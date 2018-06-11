defmodule Antsynth.Server do
  use GenServer
  alias Antsynth.Playground

  # client api
  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    Playground.new(args)
  end

  def handle_call(msg, from, state) do
  end

  def handle_cast(msg, state) do
  end
end
