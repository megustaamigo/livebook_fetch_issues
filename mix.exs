defmodule LivebookProject.MixProject do
  use Mix.Project

  def project do
    [
      app: :livebook_project,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {LivebookProject.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0.0"},
      {:jason, "~> 1.2"},
      {:poison, "~> 3.1"},
      {:vega_lite, "~> 0.1.9"},
      {:kino_vega_lite, "~> 0.1.11"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:req, "~> 0.5.6"}
    ]
  end
end
