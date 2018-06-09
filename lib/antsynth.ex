defmodule Antsynth do
  @moduledoc """
  Antsynth is an ants-simulation-driven midi sequencer.
  A colony of simulated ants is placed on a playground of hexagonal tiles.
  The tiles maps the harmonic table music note layout.

  The field has some random distributed food enriched tiles in it.
  The ants walks around lookin for food.
  When an ant finds the food it collects and brings it home.
  Food carrying ants leave a pheromones trace in the walked tiles.
  The pheromone trace fade with time.
  When ants encounter a pheromone trace they follow it (away from home).
  Ants choose always the strongest pheromone trace to follow.

  """

  @doc """
  Hello Antsynth.

  ## Examples

      iex> Antsynth.hello
      "Welcome in Antsynth!"

  """
  def hello do
    "Welcome in Antsynth!"
  end
end
