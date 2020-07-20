defmodule PageParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :page_parser,
      description: "Parse urls for links and images",
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PageParser, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:floki, "~> 0.27.0"},
      {:bypass, "~> 1.0", only: :test},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md),
      maintainers: ["Opak Alex"],
      licenses: ["Unlicense"],
      links: %{"GitHub" => "https://github.com/OpakAlex/page_parser"}
    ]
  end
end
