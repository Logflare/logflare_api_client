defmodule LogflareApiClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :logflare_api_client,
      version: "0.2.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {LogflareApiClient.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4.0"},
      {:jason, ">= 1.0.0"},
      {:mint, "~> 1.2.0"},
      {:finch, "~> 0.5"},
      {:castore, "~> 0.1"},
      {:bertex, "~> 1.3"},
      {:bypass, "~> 2.1", only: :test},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false}
    ]
  end
end
