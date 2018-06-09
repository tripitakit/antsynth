defmodule Antsynth.MixProject do
  use Mix.Project

  def project do
    [
      app: :antsynth,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Antsynth.Application, []}
    ]
  end

  defp deps do
    [
      {:hexgrid, "~> 2.1"}
    ]
  end
end
